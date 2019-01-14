ActiveAdmin.register Account do
  actions :index, :new, :edit, :destroy, :create, :update

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: Hash[User.all.map{ |u| ["#{u.last_name} #{u.first_name}", u.id] }]
      f.input :name
      f.input :status, as: :select, collection: Account::ACCOUNT_STATUSES
      f.input :amount
    end
    f.buttons
  end
end
