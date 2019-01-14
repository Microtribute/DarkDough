class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :presence => true
    add_column :users, :last_name, :string, :presence => true
    add_column :users, :phone_number, :string
    add_column :users, :country, :string, :presence => true

    add_index :users, :first_name
    add_index :users, :last_name
  end
end
