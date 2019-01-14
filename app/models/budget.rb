class Budget < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :category, :amount, :period, :start, :user_id, :tag_list, :budget_type
  belongs_to :user
  belongs_to :category
  
  validates :category, :amount, :period, :budget_type, :presence => true
  validates :amount, :period, :numericality => true
  validates :budget_type, :inclusion => { :in => %w(income spending) }

  scope :income, where(:budget_type => 'income')
  scope :spending, where(:budget_type => 'spending')
  scope :in_this_month, where('created_at >= ?', Date.today.beginning_of_month)
  
  
  def self.search(start_date, end_date)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.zone.now : end_date
      where('created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day)
    else
      in_this_month
    end
  end
end
