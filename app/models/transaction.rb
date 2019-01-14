class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  CATEGORIES = YAML.load_file("#{Rails.root}/config/categories.yml")

  validates :category, :amount, :description, :presence => true
  validates :amount, :numericality => true
  validates :category, :inclusion => { :in => CATEGORIES }

  scope :by_category, lambda { |q| {:conditions => ["category like :q", {:q => "%#{q}%"}]} }
  scope :spending_transactions, lambda { where("category != ?", "income") }
  scope :in_this_month, :conditions => ["created_at >= ?", Date.today.beginning_of_month]

  def amounts_sum(category)
    by_category(category).map(&:amount).sum
  end

  def self.search(start_date, end_date, category = '')
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day])
    else
      if category == 'spending'
        spending_transactions.in_this_month
      else
        by_category("Income").in_this_month
      end
    end
  end

  def self.find_amount(start_date, end_date)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day]).map{|transaction| transaction.amount}.sum
    else
      in_this_month.find(:all).map{|transaction| transaction.amount}.sum
    end
  end

  def self.by_account(account)
    find_all_by_account_id(account.id)
  end

  def self.transactions_by_month
    spending_transactions.find(:all).group_by{ |transaction| transaction.created_at.month }.sort
  end
end
