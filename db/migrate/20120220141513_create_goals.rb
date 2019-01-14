class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :category
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0
      t.date :planned_date
      t.decimal :contribution, :precision => 10, :scale => 2, :default => 0

      t.references :user, :null => false

      t.timestamps
    end
  end
end
