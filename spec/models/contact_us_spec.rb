require 'spec_helper'

describe ContactUs do
  before(:each) do
    @attr = { :full_name => "John Doe", :email => "john@doe.com", :text => "Email text" }
  end

  it "should create a new instance given valid attributes" do
    ContactUs.create!(@attr)
  end

  it "should require full name" do
    failed_email = ContactUs.new(@attr.merge(:full_name => ""))
    failed_email.should_not be_valid
  end

  it "should require an email" do
    failed_email = ContactUs.new(@attr.merge(:email => ""))
    failed_email.should_not be_valid
  end

  it "should require a text" do
    failed_email = ContactUs.new(@attr.merge(:text => ""))
    failed_email.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_form = ContactUs.new(@attr.merge(:email => address))
      valid_form.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      valid_form = ContactUs.new(@attr.merge(:email => address))
      valid_form.should_not be_valid
    end
  end
end
