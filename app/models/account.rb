class Account < ActiveRecord::Base
  ACCOUNT_STATUSES = ['active', 'inactive']

  attr_accessible :name, :status, :bank_id, :user_id, :amount, :transactions_attributes

  validates :name, :status, :presence => true 
  validates :status, :inclusion => { :in => ACCOUNT_STATUSES }

  belongs_to :user
  has_one :bank
  has_many :transactions
  has_and_belongs_to_many :goals

  accepts_nested_attributes_for :transactions
end
