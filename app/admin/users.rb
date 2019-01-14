ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :last_sign_in_at
    column :created_at
    column :updated_at
    column :first_name
    column :last_name
    column :phone_number
    column :country
    column :age
    column :gender
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :country
      f.input :age
      f.input :gender, as: :select, collection: User::GENDERS
    end
    f.buttons
  end

end
