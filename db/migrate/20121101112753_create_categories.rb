class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_type
      t.string :name
      
      t.timestamps
    end
    
    categories = YAML.load_file("#{Rails.root}/config/categories.yml")
    
    categories.each do |category|
      Category.create(name: category, category_type: 'spending')
    end
  end
end
