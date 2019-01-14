class Bank < ActiveRecord::Base
  attr_accessible :name
  has_many :accounts

  validates :name, :presence => true
end
