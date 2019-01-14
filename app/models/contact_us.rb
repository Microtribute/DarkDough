class ContactUs < ActiveRecord::Base
  attr_accessible :full_name, :email, :text

  validates :full_name, :email, :text, :presence => true
  validates :email, :format => { :with => Devise::email_regexp, :message => "format is wrong" }
end
