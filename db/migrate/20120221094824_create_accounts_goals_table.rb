class CreateAccountsGoalsTable < ActiveRecord::Migration
  def self.up
    create_table :accounts_goals, :id => false do |t|
      t.references :account
      t.references :goal
    end
    add_index :accounts_goals, [:account_id, :goal_id]
    add_index :accounts_goals, [:goal_id, :account_id]
  end

  def self.down
    drop_table :accounts_goals
  end
end