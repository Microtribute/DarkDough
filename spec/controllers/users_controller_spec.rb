require 'spec_helper'

describe UsersController do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "#show" do
    it "should be success" do
      @account = FactoryGirl.create(:account, :user_id => @user.id)
      get :show, :id => @user
      response.should be_success
    end

    it "should reject without an account" do
      get :show, :id => @user
      response.should_not be_success
    end

    # it "should find the right user" do
    #   get :show, :id => @user
    #   assigns[:user].should eq(@user)
    # end
  end
end
