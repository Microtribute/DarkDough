require 'spec_helper'

describe StaticController do
  render_views

  describe "GET 'home'" do
    it "should be success" do
      get :home
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be success" do
      get :about
      response.should be_success
    end
  end

  describe "GET 'FAQ'" do
    it "should be success" do
      get :faq
      response.should be_success
    end
  end

  describe "GET 'how_it_works'" do
    it "should be success" do
      get :how_it_works
      response.should be_success
    end
  end

  describe "GET 'terms_of_use'" do
    it "should be success" do
      get :terms_of_use
      response.should be_success
    end
  end

  describe "GET 'help_create_account'" do
    it "should be success" do
      @user = FactoryGirl.create(:user)
      sign_in @user

      get :help_create_account, :user => @user
      response.should be_success
    end
  end
end
