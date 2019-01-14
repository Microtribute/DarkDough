class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :full_name
      t.string :email
      t.text :text

      t.timestamps
    end
  end
end
