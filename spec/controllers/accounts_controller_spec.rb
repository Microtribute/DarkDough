require 'spec_helper'

describe AccountsController do
  render_views

  def valid_attributes
    { :name => "Johny's account", :status => "active", :user_id => '1'}
  end

  before :each do
    @user = FactoryGirl.create(:user)
    @bank = FactoryGirl.create(:bank)
    @account = FactoryGirl.create(:account, :user => @user, :bank => @bank)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all accounts as @accounts" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    # it "assigns the requested account as @account" do
    #   get :show, :id => @account
    #   response.should be_success
    # end
  end

  describe "GET new" do
    it "assigns a new account as @account" do
      get :new
      assigns(:account).should be_a_new(Account)
    end
  end

  describe "GET edit" do
    it "should be successful" do
      new_name = "New account name"
      @account.name = new_name
      @account.save!
      response.code.should == '200'
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, :account => valid_attributes
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, :account => valid_attributes
        assigns(:account).should be_a(Account)
        assigns(:account).should be_persisted
      end

      it "redirects to the created account" do
        post :create, :account => valid_attributes
        response.should redirect_to(Account)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        post :create, :account => {}
        assigns(:account).should be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        post :create, :account => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested account" do
        account = Account.create! valid_attributes
        Account.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => account.id, :account => {'these' => 'params'}
      end

      it "assigns the requested account as @account" do
        account = Account.create! valid_attributes
        put :update, :id => account.id, :account => valid_attributes
        assigns(:account).should eq(account)
      end

      it "redirects to the account" do
        account = Account.create! valid_attributes
        put :update, :id => account.id, :account => valid_attributes
        response.should redirect_to(account)
      end
    end

    describe "with invalid params" do
      it "assigns the account as @account" do
        account = Account.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        put :update, :id => account.id.to_s, :account => {}
        assigns(:account).should eq(account)
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Account.any_instance.stub(:save).and_return(false)
        put :update, :id => account.id.to_s, :account => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
      expect {
        delete :destroy, :id => account.id.to_s
      }.to change(Account, :count).by(-1)
    end

    it "redirects to the accounts list" do
      account = Account.create! valid_attributes
      delete :destroy, :id => account.id.to_s
      response.should redirect_to(accounts_url)
    end
  end
end
