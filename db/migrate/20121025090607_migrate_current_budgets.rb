class MigrateCurrentBudgets < ActiveRecord::Migration
  def change
    Budget.all.each do |budget|
      if budget.category == "Income"
        budget.budget_type = 'income'
      else
        budget.budget_type = 'spending'
        budget.amount = budget.amount - budget.amount - budget.amount
      end
      budget.save
    end
  end
end
