class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :answer
      t.string :answer_sort

      t.timestamps
    end
  end
end
