class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    @title = 'Dashboard - Budget 24/7'
    @goals = current_user.goals
    @budgets = current_user.budgets
    @spending_transactions = current_user.transactions.spending_transactions
    @transactions_by_month = current_user.transactions.transactions_by_month
  end
end
