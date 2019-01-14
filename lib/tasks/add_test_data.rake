desc "Add test users for fast signing in"
namespace :db do
  task :seed => :environment do
    Rake::Task['db:reset'].invoke

    User.create!(:first_name => "Eugene", :last_name => "K.",
                 :email => "user1@mailinator.com", :country => "Ukraine", :phone => "0123456789",
                 :password => "epyfnm", :password_confirmation => "epyfnm", :age => '26', :gender => 'Male')

    AdminUser.create!(email: 'budget247admin@mailinator.com', password: 'medmex_86!b')
    AdminUser.create!(email: 'admin@example.com', password: 'password')

    Rake::Task['db:reset'].invoke
    3.times do |n|
      Bank.create!(:name => "Bank #{n+1}")

      Transaction.create!(:description => "Phone's transactions.", :category => "Phone",
                          :amount => 10*(n+1), :user_id => "1", :account_id => "1")
      Transaction.create!(:description => "#{n+1} 'income' transactions.", :category => "Income",
                          :amount => 100*(n+1), :user_id => "1", :account_id => "2")
    end

    Transaction.create!(:description => "Shoes", :category => "Shoping", :amount => 600, :user_id => "1", :created_at => "2012-01-14", :account_id => "1")
    Transaction.create!(:description => "Dinner", :category => "Restaurants", :amount => 4000, :user_id => "1", :created_at => "2012-01-23", :account_id => "2")
    Transaction.create!(:description => "Medicine", :category => "Medicine", :amount => 800, :user_id => "1", :created_at => "2012-02-13", :account_id => "2")
    Transaction.create!(:description => "Medicine", :category => "Medicine", :amount => 4000, :user_id => "1", :created_at => "2012-01-11", :account_id => "1")
    Transaction.create!(:description => "Somewhere", :category => "Clothes", :amount => 125, :user_id => "1", :created_at => "2012-02-25", :account_id => "2")
    Transaction.create!(:description => "Income", :category => "Income", :amount => 2000, :user_id => "1", :created_at => "2012-01-07", :account_id => "1")
    Transaction.create!(:description => "Income", :category => "Income", :amount => 3000, :user_id => "1", :created_at => "2012-02-05", :account_id => "1")

    Budget.create!(:category => Transaction::CATEGORIES[1], :amount => 25, :period => "1", :user_id => "1")
    Budget.create!(:category => Transaction::CATEGORIES[2], :amount => 550, :period => "1", :user_id => "1")
    Budget.create!(:category => Transaction::CATEGORIES[3], :amount => 75, :period => "1", :user_id => "1")

    b04 = Budget.create!(:category => Transaction::CATEGORIES[4], :amount => 100, :period => "1", :user_id => "1")
    b04.created_at = Date.today - 20.days
    b04.save
    b05 = Budget.create(:category => Transaction::CATEGORIES[5], :amount => 125, :period => "1", :user_id => "1")
    b05.created_at = Date.today - 15.days
    b05.save

    Budget.create!(:category => Transaction::CATEGORIES[6], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    Budget.create!(:category => Transaction::CATEGORIES[7], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b08 = Budget.create!(:category => Transaction::CATEGORIES[8], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b08.created_at = Date.today + 2.days
    b08.save
    b09 = Budget.create(:category => Transaction::CATEGORIES[9], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b09.created_at = Date.today - 32.days
    b09.save
    b10 = Budget.create(:category => Transaction::CATEGORIES[10], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b10.created_at = Date.today - 1.month
    b10.save

    Account.create!(:name => 'Test account', :status => 'active', :bank_id => '3', :amount => 1000, :user_id => 1)
    Account.create!(:name => 'Test account 2', :status => 'active', :bank_id => '2', :amount => 200, :user_id => 1)
  end
end
