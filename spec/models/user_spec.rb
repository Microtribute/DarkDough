require 'spec_helper'

describe User do
  before(:each) do
    @user_attr = { :email => "email@example.com", :first_name => "John", :last_name => "Doe",
                   :password => "foobar", :password_confirmation => "foobar",
                   :country => "Hungary", :age => "22", :gender => "Male" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@user_attr)
  end

  it "should require a first name" do
    no_first_name_user = User.new(@user_attr.merge(:first_name => ""))
    no_first_name_user.should_not be_valid
  end

  it "should require a last name" do
    no_last_name_user = User.new(@user_attr.merge(:last_name => ""))
    no_last_name_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@user_attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should require a country for user" do
    no_country_user = User.new(@user_attr.merge(:country => ""))
    no_country_user.should_not be_valid
  end

  it "should reject first_name that are too long" do
    long_first_name = "a"*31
    long_first_name_user = User.new(@user_attr.merge(:first_name => long_first_name))
    long_first_name_user.should_not be_valid
  end

  it "should reject last_name that are too long" do
    long_last_name = "a"*31
    long_last_name = User.new(@user_attr.merge(:last_name => long_last_name))
    long_last_name.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@user_attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@user_attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@user_attr)
    user_with_duplicate_email = User.new(@user_attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @user_attr[:email].upcase
    User.create!(@user_attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should have valid country" do
    user = FactoryGirl.create(:user, :country => "Ukraine")
    Carmen::country_names.should include(user.country)
  end

  describe "password validation" do
    it "should require a password" do
      User.new(@user_attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@user_attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a"*5
      hash = @user_attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a"*129
      hash = @user_attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
end
