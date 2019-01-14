class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :category
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0
      t.string :period
      t.datetime :start

      t.references :user

      t.timestamps
    end
  end
end
