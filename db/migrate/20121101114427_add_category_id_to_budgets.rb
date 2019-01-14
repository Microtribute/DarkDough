class AddCategoryIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :category_id, :integer
    Budget.all.each do |budget|
      budget.category = Category.find_by_name(budget.attributes['category'])
      budget.save
    end
    remove_column :budgets, :category
  end
end
