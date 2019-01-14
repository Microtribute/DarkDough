require 'spec_helper'

describe ContactUsController do
  render_views

  before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe '#create' do
    it "should send email to support" do
      post :create, :contact_us => {
        :full_name => 'John Doe', :email => 'doe@mailinator.com',
        :text => 'Thanks you - great work!'
      }

      mail = ActionMailer::Base.deliveries.first
      mail.to.should == ["pfm.sup.psodhfoih2904@gmail.com"]
      mail.from.should == 'John Doe doe@mailinator.com'
      mail.subject.should == "PFM support request"
      mail.body.should include('Name:')
      mail.body.should include('Email:')

      response.should redirect_to(root_url)
    end

    it "should validate ContactUs model" do
      post :create, :contact_us => {
        :full_name => nil, :email => 'doe@mailinator.com',
        :text => 'Thanks you - great work!'
      }

      ActionMailer::Base.deliveries.should be_empty
      response.should render_template('new')
    end
  end
end
