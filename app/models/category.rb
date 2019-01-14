class Category < ActiveRecord::Base
  has_many :budgets
  
  CATEGORY_TYPES = %w(income spending)
  
  scope :income, where(:category_type => 'income')
  scope :spending, where(:category_type => 'spending')
  
  validates :category_type, :inclusion => { :in => CATEGORY_TYPES }
end
