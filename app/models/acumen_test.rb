class AcumenTest < ActiveRecord::Base
  include AcumenTestHelper

  attr_accessible :result, :finished, :answers_attributes

  belongs_to :user
  has_many :answers

  accepts_nested_attributes_for :answers

  INCOME_EXCEPT_FROM_TAX = 30000

  def finished?
    finished ? "finished" : "not finished yet"
  end

  def is_finished?
    !(self.answers.map(&:result).include?(nil) || self.answers.map(&:result).include?(""))
  end

  def finish_it!
    if self.is_finished?
      self.finished = true
      self.save
    else
      self.finished = false
      self.save
    end
  end

  # def calculate_acumen_test
  # end

  def qualitative_test_finished?
    !(test_answers('t1').map(&:result).include?(nil) || test_answers('t1').map(&:result).include?(""))
  end

  def quantitative_test_finished?
    !(test_answers('t2').map(&:result).include?(nil) || test_answers('t2').map(&:result).include?(""))
  end

  def cash_flow_test_finished?
    !(test_answers('t3').map(&:result).include?(nil) || test_answers('t3').map(&:result).include?(""))
  end

  def test_answers(code)
    self.answers.answers_by_code(code)
  end

  def qualitative_result
    qualitative_answers = test_answers('t1')
    result = {:worry => worry_count(qualitative_answers),
              :self_interest => self_interest_count(qualitative_answers),
              :discipline => discipline_count(qualitative_answers),
              :motivation => motivation_count(qualitative_answers),
              :thrill_seeking => thrill_seeking_count(qualitative_answers) }
  end

  def quantitative_result
    quantitative_answers = test_answers('t2')
    result = {:total_investments => total_investments_count(quantitative_answers),
              :total_assets => total_assets_count(quantitative_answers),
              :total_liabilities => total_liabilities_count(quantitative_answers),
              :current_ratio => current_ratio_count(quantitative_answers),
              :debt_ratio => debt_ratio_count(quantitative_answers),
              :net_worth => net_worth_count(quantitative_answers),
              :net_worth_to_income_ratio => net_worth_to_income_ratio_count(quantitative_answers) }
  end

  def cash_flow_result
    result = {:total_income => total_income_count,
              :total_expenditures => total_expenditures_count }
  end

  def worry_events_count(test_answers)
    worry_array = []
    Answer::WORRY_EVENTS.each do |code|
      test_answers.find{ |answer| worry_array << answer.result if (answer.code == code) }
    end
    res_array = []
    worry_array.each do |elem|
      case elem
      when "0"
        res_array << "1"
      when "1"
        res_array << "0.5"
      when "2"
        res_array << "2"
      when "-2"
        res_array << "-2"
      end
    end
    result = res_array.compact.map(&:to_i).sum
  end

  def worry_count(test_answers)
    worry_array = []
    Answer::WORRY.each do |code|
      test_answers.find{ |answer| worry_array << answer.result if (answer.code == code) }
    end
    worry_result = worry_array.compact.map(&:to_i).sum + worry_events_count(test_answers)
  end

  def self_interest_count(test_answers)
    self_interest_array = []
    Answer::SELF_INTEREST.each do |code|
      test_answers.find{ |answer| self_interest_array << answer.result if (answer.code == code) }
    end
    self_interest = self_interest_array.compact.map(&:to_i).sum

    self_interest_deduct_array = []
    Answer::SELF_INTEREST_DEDUCT.each do |code|
      test_answers.find{ |answer| self_interest_deduct_array << answer.result if (answer.code == code) }
    end
    self_interest_deduct = self_interest_deduct_array.compact.map(&:to_i).sum
    self_interest_result = self_interest - self_interest_deduct + goals_and_aspirations + lifestyle - legacy + thrift
  end

  def discipline_count(test_answers)
    discipline_array = []
    Answer::DISCIPLINE.each do |code|
      test_answers.find{ |answer| discipline_array << answer.result if (answer.code == code) }
    end
    discipline_result = discipline_array.compact.map(&:to_i).sum
  end

  def motivation_count(test_answers)
    motivation_array = []
    Answer::MOTIVATION.each do |code|
      test_answers.find{ |answer| motivation_array << answer.result if (answer.code == code) }
    end
    motivation = motivation_array.compact.map(&:to_i).sum

    motivation_deduct_array = []
    Answer::MOTIVATION_DEDUCT.each do |code|
      test_answers.find{ |answer| motivation_deduct_array << answer.result if (answer.code == code) }
    end
    motivation_deduct = motivation_deduct_array.compact.map(&:to_i).sum
    motivation_result = motivation - motivation_deduct + traditions + legacy - lifestyle + thrift
  end

  def thrill_seeking_count(test_answers)
    thrill_seeking_array = []
    Answer::THRILL_SEEKING.each do |code|
      test_answers.find{ |answer| thrill_seeking_array << answer.result if (answer.code == code) }
    end
    thrill_seeking = thrill_seeking_array.compact.map(&:to_i).sum

    thrill_seeking_deduct_array = []
    Answer::THRILL_SEEKING_DEDUCT.each do |code|
      test_answers.find{ |answer| thrill_seeking_deduct_array << answer.result if (answer.code == code) }
    end
    thrill_seeking_deduct = thrill_seeking_deduct_array.compact.map(&:to_i).sum
    thrill_seeking_result = thrill_seeking - thrill_seeking_deduct
  end

  # quantitative calculations
  def total_investments_count(test_answers)
    results_array = []
    Answer::TOTAL_INVESTMENTS.each do |code|
      test_answers.find{ |answer| results_array << answer.result if (answer.code == code) }
    end
    result = results_array.compact.map(&:to_f).sum
  end

  def total_assets_count(test_answers)
    results_array = []
    Answer::TOTAL_ASSETS.each do |code|
      test_answers.find{ |answer| results_array << answer.result if (answer.code == code) }
    end
    result = results_array.compact.map(&:to_f).sum
  end

  def total_liabilities_count(test_answers)
    results_array = []
    Answer::TOTAL_LIABILITIES.each do |code|
      test_answers.find{ |answer| results_array << answer.result if (answer.code == code) }
    end
    result = results_array.compact.map(&:to_f).sum
  end

  def current_ratio_count(test_answers)
    res = (total_assets_count(test_answers).to_f / total_liabilities_count(test_answers).to_f).to_f
    sprintf("%.2f", res).to_f
  end

  def debt_ratio_count(test_answers)
    res = (total_liabilities_count(test_answers).to_f / net_worth_count(test_answers).to_f).to_f
    sprintf("%.2f", res).to_f
  end

  def net_worth_count(test_answers)
    total_assets_count(test_answers) - total_liabilities_count(test_answers)
  end

  def net_worth_to_income_ratio_count(test_answers)
    res = (net_worth_count(test_answers).to_f / total_income_count.to_f).to_f
    sprintf("%.2f", res).to_f
  end

  # cash flow calculations
  def total_income_count
    net_salary + net_business_income + base_income
  end

  def total_expenditures_count
    test_answers = self.test_answers('t3')
    result_array = []
    Answer::TOTAL_EXPENDITURES.each do |code|
      test_answers.find{ |answer| result_array << answer.result if (answer.code == code) }
    end
    result_array << rent_count
    result_array.compact.map(&:to_f).sum
  end

  def cash_surplus_deficite
    total_income_count - total_expenditures_count
  end
end
