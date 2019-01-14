class TrendsController < ApplicationController
  before_filter :authenticate_user!
  require 'active_support/core_ext/date/conversions'

  def index
    @title = "Trends - Budget 24/7"
    @top_merchant = current_user.top_merchant
    @most_purchased  = current_user.most_purchased
    @most_expensive = current_user.transactions.find(:all, :order => 'amount DESC').first

    @transactions = current_user.transactions.search(params[:trends_start], params[:trends_end])
    @spending_transactions = current_user.transactions.spending_transactions.search(params[:trends_start], params[:trends_end], 'spending')
    @income_transactions = current_user.transactions.by_category('Income').search(params[:trends_start], params[:trends_end], 'income')

    @spending_by_category_json = {
      :name => 'flare', :children => category_listed(@spending_transactions).map{ |category, amount| {
        :name => category, :children => [{ :name => category, :size => amount }] }}}.to_json


    @spending_over_time_json = {
      :name => 'flare', :children => time_listed(@spending_transactions).map{ |month, amount| {
        :name => Date::MONTHNAMES[month.to_i], :children => [{ :name => Date::MONTHNAMES[month.to_i], :size => amount }] }}}.to_json

    @spending_by_merchant_json = {
      :name => 'flare', :children => merchant_listened(@spending_transactions).map{ |description, amount| {
        :name => description, :children => [{ :name => description, :size => amount }] }}}.to_json

    @income_by_category_json = {
      :name => "flare", :children => category_listed(@income_transactions).map { |category, amount| {
          :name => category, :children => [{ :name => category, :size => amount.to_f}] }}}.to_json

    @income_over_time_json = {
      :name => 'flare', :children => time_listed(@income_transactions).map{ |month, amount| {
        :name => Date::MONTHNAMES[month.to_i], :children => [{ :name => Date::MONTHNAMES[month.to_i], :size => amount }] }}}.to_json

    @income_by_merchant_json = {
      :name => 'flare', :children => merchant_listened(@income_transactions).map{ |description, amount| {
        :name => description, :children => [{ :name => description, :size => amount }] }}}.to_json

    @net_income_over_time_json = {
      :name => 'flare', :children => net_income_time_listed(@transactions).map{ |category, hash| {
         :name => category, :children => hash.map{ |month, amount| {
           :name => "#{Date::MONTHNAMES[month.to_i]} (#{category.downcase})", :size => amount}}}}}.to_json

    @income_amount = current_user.transactions.by_category('Income').find_amount(params[:trends_start], params[:trends_end])
    @spending_amount = current_user.transactions.spending_transactions.find_amount(params[:trends_start], params[:trends_end])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def category_listed(transactions)
    hash_array = []
    categories = transactions.map{ |transaction| transaction.category }.uniq
    categories.each do |category|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount if transaction.category == category
      end
      hash_array << amounts.sum
      hash_array << category
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end

  def time_listed(transactions)
    hash_array = []
    months = transactions.map{ |transaction| transaction.created_at.month }.uniq
    months.each do |month|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount.to_i if transaction.created_at.month == month
      end
      hash_array << amounts.sum
      hash_array << month.to_s
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end

  def merchant_listened(transactions)
    hash_array = []
    descriptions = transactions.map{ |transaction| transaction.description }.uniq
    descriptions.each do |description|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount.to_i if transaction.description == description
      end
      hash_array << amounts.sum
      hash_array << description
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end

  def net_income_time_listed(transactions)
    months = transactions.map{ |transaction| transaction.created_at.month }.uniq
    incomes = @income_transactions
    spendings = @spending_transactions
    result_income = []
    result_spending = []
    result = {}

    months.each do |month|
      income_amounts = []
      incomes.each do |income|
        income_amounts << income.amount.to_i if income.created_at.month == month
      end
      result_income << income_amounts.sum
      result_income << month.to_s
    end
    result_income = Hash[*result_income.reverse]

    months.each do |month|
      spending_amounts = []
      spendings.each do |spending|
        spending_amounts << spending.amount.to_i if spending.created_at.month == month
      end
      result_spending << spending_amounts.sum
      result_spending << month.to_s
    end
    result_spending = Hash[*result_spending.reverse]

    result = { 'income' => result_income, 'spending' => result_spending }
  end
end
