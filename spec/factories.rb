FactoryGirl.define do
  factory :user do |f|
    f.first_name            "Johny"
    f.last_name             "Nesh"
    f.email                 { FactoryGirl.generate(:email) }
    f.country               "Albania"
    f.phone_number          "0123456789"
    f.password              "password"
    f.password_confirmation "password"
    f.age                   "22"
    f.gender                "Male"
  end

  factory :account do |f|
    f.name   "First account"
    f.status "active"
    f.amount "1000"
    # association :user, :factory => :user
  end

  factory :bank do |f|
    f.name   "Union bank"
  end

  factory :budget do |f|
    f.category "Phone"
    f.period "1 month"
    f.amount "1234"
  end

  factory :goal do |f|
    f.title "Factory goal"
    f.category Goal::GOAL_CATEGORIES[0]
    f.amount '10000'
    f.contribution '200'
    f.planned_date Date.today + 1.year
  end

  factory :transaction do |f|
    f.category "Phone"
    f.description "Some description"
    f.amount "123"
    f.note "Some note"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

