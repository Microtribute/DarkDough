class AddSmsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :sms, :string
  end

  def down
    remove_column :users, :sms
  end
end
