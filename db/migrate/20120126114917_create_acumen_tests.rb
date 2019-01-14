class CreateAcumenTests < ActiveRecord::Migration
  def change
    create_table :acumen_tests do |t|
      t.string :result
      t.boolean :finished, :default => false

      t.references :user, :null => false

      t.timestamps
    end
  end
end
