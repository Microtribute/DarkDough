class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :status
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0, :null => false

      t.references :user, :null => false
      t.references :bank

      t.timestamps
    end
  end
end
