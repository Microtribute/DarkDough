class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :result
      t.string :code
      t.text :question

      t.references :acumen_test, :null => false

      t.timestamps
    end
  end
end
