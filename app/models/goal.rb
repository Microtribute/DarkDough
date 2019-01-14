class Goal < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :accounts

  attr_accessible :title, :category, :amount, :contribution, :planned_date, :user_id, :account_ids, :finished

  GOAL_PREDEFINED_CATEGORIES = ["Family/Personal Vacation", "School Tuition", "Save for an emergency",
                                "Mortgage Contribution", "Buy Home", "Build Home", "Investment Opportunity",
                                "Safety Net", "Business Capital", "Wedding", "Anniversary/Birthday",
                                "Charitable Giving", "Car", "House Rent", "Repay Debt", "Create Custom Goal"]

  GOAL_CATEGORIES = ["Babies and Kids", "Bill and Taxes", "Electronics", "Gifts and Shopping",
                     "Wedding", "Other", "Furniture"]

  validates :title, :category, :amount, :contribution, :planned_date, :presence => true
  validates :category, :inclusion => { :in => GOAL_PREDEFINED_CATEGORIES | GOAL_CATEGORIES }
  validates :amount, :numericality => true

  def available_balance
    accounts.map{ |account| account.amount}.sum.to_f
  end

  def todays_balance
    self.amount - available_balance
  end

  def can_be_finished?
    (todays_balance <= 0) && (self.finished == false)
  end

  def finished?
    self.finished == true
  end
end
