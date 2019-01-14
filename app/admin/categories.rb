ActiveAdmin.register Category do
  form do |f|
    f.inputs "Details" do
      f.input :category_type, :as => :radio, :collection => Category::CATEGORY_TYPES
      f.input :name
    end
    f.buttons
  end
  
  index do
    column :id
    column :category_type
    column :name
    default_actions
  end
  
  filter :category_type, :as => :select, :collection => Category::CATEGORY_TYPES
  filter :name
end
