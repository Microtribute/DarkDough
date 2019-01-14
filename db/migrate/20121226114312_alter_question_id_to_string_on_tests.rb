class AlterQuestionIdToStringOnTests < ActiveRecord::Migration
  def up
    change_column :tests, :question_id, :string
  end

  def down
    change_column :tests, :question_id, :integer
  end
end
