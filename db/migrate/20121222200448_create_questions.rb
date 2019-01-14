class CreateQuestions < ActiveRecord::Migration
  def up
		create_table :questions do |t|
			t.integer :korder
			t.string :answer_type
			t.integer :qgroup
			t.string :trait
      t.string :question
      t.timestamps
    end
  end

  def down
		drop_table :questions
  end
end
