class AddFinishedToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :finished, :boolean, :default => 0
  end
end
