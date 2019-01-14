class AddBudgetTypeToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :budget_type, :string
  end
end
