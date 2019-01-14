module AcumenTestHelper
  def worry_test_resulting
    res = qualitative_result[:worry]
    case res.to_i
    when 30..44
      result =  "Exceptionally high"
    when 13..31
      result =  "Very high"
    when -12..12
      result =  "Average"
    when -31..-13
      result =  "Below average"
    when -44..-32
      result =  "Negligible"
    end
    return result
  end

  def motivation_test_resulting
    res = qualitative_result[:motivation]
    case res.to_i
    when 14..18
      result =  "Exceptionally high"
    when 8..13
      result =  "Very high"
    when -5..7
      result =  "Average"
    when -14..-6
      result =  "Below average"
    when -18..-15
      result =  "Negligible"
    end
    return result
  end


  def discipline_test_resulting
    res = qualitative_result[:discipline]
    case res.to_i
    when 14..18
      result =  "Exceptionally high"
    when 8..13
      result =  "Very high"
    when -5..7
      result =  "Average"
    when -14..-6
      result =  "Below average"
    when -18..-15
      result =  "Negligible"
    end
    return result
  end

  def self_interest_test_resulting
    res = qualitative_result[:self_interest]
    case res.to_i
    when 22..30
      result =  "Exceptionally high"
    when 11..21
      result =  "Very high"
    when -10..10
      result =  "Average"
    when -22..-11
      result =  "Below average"
    when -30..-23
      result =  "Negligible"
    end
    return result
  end

  def thrill_seeking_test_resulting
    res = qualitative_result[:thrill_seeking]
    case res.to_i
    when 15..22
      result =  "Exceptionally high"
    when 9..14
      result =  "Very high"
    when -6..8
      result =  "Average"
    when -15..-7
      result =  "Below average"
    when -22..-16
      result =  "Negligible"
    end
    return result
  end

  def set_user_group(test_result)
    case test_result
    when "Exceptionally high"
      user_group = "Livewires"
    when "Very high"
      user_group = "Sovereigns"
    when "Average"
      user_group = "Swashbucklers"
    when "Below average"
      user_group = "Adherents"
    when "Negligible"
      user_group = "Nihilists"
    end
    return user_group
  end

  def goals_and_aspirations
    gaa_array = ["t1q46", "t1q47", "t1q48", "t1q49", "t1q50", "t1q51"]
    result_array = []
    gaa_array.each do |arr|
      test_answers('t1').find{ |answer| result_array << answer.result if (answer.code == arr) }
    end
    res = result_array.map(&:to_f).sum
    case res
      when 0
        result = "-2"
      when 1
        result = "-1"
      when 2
        result = "1"
      when 3,4,5
        result = "2"
    end
    return result.to_i
  end

  def traditions
    answer_result = test_answers('t1').find_by_code("t1q56").result
    case answer_result.to_i
    when 0
      result = "-2"
    when 1
      result = "-1"
    when 2
      result = "1"
    when 3,4,5
      result = "2"
    end
    return result.to_i
  end

  def financial_priorities_algorithm(res)
    case res
    when nil
      result = "0"
    when "1"
      result = 2
    when "2"
      result = 1
    when "3"
      result = 0.5
    end
    return result
  end

  def legacy
    answer_result = test_answers('t1').find_by_code("t1q53").result
    financial_priorities_algorithm(answer_result)
  end

  def lifestyle
    answer_result = test_answers('t1').find_by_code("t1q54").result
    financial_priorities_algorithm(answer_result)
  end

  def thrift
    answer_result = test_answers('t1').find_by_code("t1q55").result
    return 0
  end

  # cash flow calculations
  def apply_paye?
    self.answers.find_by_code('t3q03').result == "1"
  end

  def apply_income_tax?
    self.answers.find_by_code('t3q11').result == "1"
  end

  # income calculations
  def net_salary
    gross_salary = self.answers.find_by_code('t3q01').result.to_f
    less_paye = self.answers.find_by_code('t3q02').result.to_f

    apply_paye? ? gross_salary - paye(residual_amount) : gross_salary - less_paye
  end

  def paye(user_residual_amount)
    case user_residual_amount
    when -999999..0
      res = 0
    when 0..30000
      res = user_residual_amount * 0.05
    when 30000..60000
      res = 1500 + (user_residual_amount - 30000) * 0.1
    when 60000..110000
      res = 4500 + (user_residual_amount - 60000) * 0.15
    when 110000..160000
      res = 21000 + (user_residual_amount - 110000) * 0.2
    else
      res = 53000 + (user_residual_amount - 160000) + 0.25
    end
    sprintf("%.2f", res).to_f
  end

  def residual_amount
    income = base_income + self.answers.find_by_code('t3q01').result.to_f
    # TODO: implement number_of_children part when we have this informaiton about users
    number_of_children = 0
    personal_allowance = income * 0.2 + 5000
    claims_for_children = number_of_children * 2500

    if income < 30000
      res = income - personal_allowance - claims_for_children
    else
      res = income - personal_allowance - claims_for_children - AcumenTest::INCOME_EXCEPT_FROM_TAX
    end
  end

  def net_business_income
    business_income = self.answers.find_by_code('t3q09').result.to_f
    less_income_tax = self.answers.find_by_code('t3q10').result.to_f

    apply_income_tax? ? business_income - business_income * Answer::COMPANY_INCOME_TAX : business_income - less_income_tax
  end

  def base_income
    test_answers = test_answers('t3')
    result_array = []
    Answer::INCOME.each do |code|
      test_answers.find{ |answer| result_array << answer.result if (answer.code == code) }
    end
    result = result_array.compact.map(&:to_f).sum
  end

  def rent_count
    year_rent = self.answers.find_by_code('t3q22').result.to_f
    sprintf("%.2f", (year_rent / 12)).to_f
  end
end
