class User < ActiveRecord::Base
  rolify
  include Paperclip::Glue

  before_validation :set_fields, :generate_password, on: :create

  USER_AGES = (8..100).to_a.map{ |e| e.to_s } << 'undef'
  GENDERS = %w(Male Female Unspecified)

  attr_accessor   :tos_confirmation

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :email,
                  :password, :password_confirmation, :country, :tos_confirmation,
                  :email, :password, :password_confirmation, :remember_me,
                  :age, :gender, :accounts_attributes, :avatar, :sms

  has_attached_file :avatar, styles: { medium: "65x65#", small: "40x40#" },
                             default_url: 'default_img/anonymous.png',
                             path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                             url: "/system/:attachment/:id/:style/:filename"



  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :rpx_connectable

  validates :first_name, :email, :phone_number, presence: true
  validates :first_name, :last_name, length: { maximum: 30 }
	before_validation do; phone = phone.to_s.gsub(/\D/, '').to_i; end

  validates :tos_confirmation, :acceptance => true, :if => :new_record?
  # TODO specify this validation in admin section. Fix errro on edit user when active
  # validates :country, :inclusion => { :in => Carmen::country_names }
  validates :age, :inclusion => { :in => USER_AGES }
  validates :gender, :inclusion => { :in => GENDERS }

  has_many :acumen_tests
	has_many :tests
  has_many :accounts
  has_many :transactions
  has_many :budgets
  has_many :answers, :through => :acumen_tests
  has_many :goals

  accepts_nested_attributes_for :accounts

  def on_before_rpx_success(rpx_data)
     #logger.info rpx_data.inspect + "\n--before_rpx_success-------------------------------"
     name = rpx_data["name"]
     unless name.nil?
        self.first_name = name["givenName"]
        self.last_name = name["familyName"] || name["givenName"]
        self.age = 'undef'
        self.gender = 'Unspecified'
        # TODO: country should be given from user current location or set to undefined
        self.country = 'Afghanistan'
        self.save
     end
  end
	
	def on_before_rpx_auto_create(rpx_user)
    logger.info rpx_user.inspect + "\n--before_rpx_auto_create-------------------------------"
  end

  def transactions_sum_by_category(category)
    arr = []
    self.transactions.each do |transaction|
      arr << transaction if transaction.category == category
    end
    arr.map{|tr| tr.amount}.sum
  end

  def transactions_categories
    self.transactions.any? ? self.transactions.map{ |transaction| transaction.category }.uniq! : []
  end

  def spending_amount
    transactions.spending_transactions.map(&:amount).sum
  end

  def most_purchased
    most_category = ''
    elems = 0
    transactions_categories.each do |category|
      if transactions.by_category(category).count > elems
        most_category = category
        elems = transactions.by_category(category).count
      end
    end
    return most_category, elems
  end

  def top_merchant
    top_category = ''
    amount = 0
    (transactions_categories-['Income']).each do |category|
      if transactions.by_category(category).map(&:amount).sum > amount
        top_category = category
        amount = transactions.by_category(category).map(&:amount).sum
      end
    end
    return top_category, amount.to_f
  end

  def total_income
    transactions_sum_by_category("Income")
  end

  private

  def set_fields
    self.age ||= 'undef'
    self.gender ||= 'Unspecified'
  end

  def generate_password
    o =  [('a'..'z'), ('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
    self.password = self.password_confirmation = (0..16).map{ o[rand(o.length)] }.join if self.password.blank?
  end
	
end
