require 'spec_helper'

describe TransactionsController do

  def valid_attributes
    { :category => "Phone", :amount => 123, :user_id => '1', :description => "Some description" }
  end

  before :each do
    @user = FactoryGirl.create(:user)
    @account = FactoryGirl.create(:account, :user => @user)
    @transaction = FactoryGirl.create(:transaction, :user => @user)
    sign_in @user
  end

  describe "GET index" do
    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be success" do
      get :show, :id => @transaction
      response.should be_success
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      assigns(:transaction).should be_a_new(Transaction)
    end
  end

  describe "GET edit" do
    it "assigns the requested transaction as @transaction" do
      transaction = Transaction.create! valid_attributes
      get :edit, :id => transaction.id.to_s
      assigns(:transaction).should eq(transaction)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, :transaction => valid_attributes
        }.to change(Transaction, :count).by(1)
      end

      it "assigns a newly created transaction as @transaction" do
        post :create, :transaction => valid_attributes
        assigns(:transaction).should be_a(Transaction)
        assigns(:transaction).should be_persisted
      end

      it "redirects to the created transaction" do
        post :create, :transaction => valid_attributes
        response.should redirect_to(Transaction.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transaction as @transaction" do
        Transaction.any_instance.stub(:save).and_return(false)
        post :create, :transaction => {}
        assigns(:transaction).should be_a_new(Transaction)
      end

      it "re-renders the 'new' template" do
        Transaction.any_instance.stub(:save).and_return(false)
        post :create, :transaction => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested transaction" do
        transaction = Transaction.create! valid_attributes
        Transaction.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => transaction.id, :transaction => {'these' => 'params'}
      end

      it "assigns the requested transaction as @transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, :id => transaction.id, :transaction => valid_attributes
        assigns(:transaction).should eq(transaction)
      end

      it "redirects to the transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, :id => transaction.id, :transaction => valid_attributes
        response.should redirect_to(transaction)
      end
    end

    describe "with invalid params" do
      it "assigns the transaction as @transaction" do
        transaction = Transaction.create! valid_attributes
        Transaction.any_instance.stub(:save).and_return(false)
        put :update, :id => transaction.id.to_s, :transaction => {}
        assigns(:transaction).should eq(transaction)
      end

      it "re-renders the 'edit' template" do
        transaction = Transaction.create! valid_attributes
        Transaction.any_instance.stub(:save).and_return(false)
        put :update, :id => transaction.id.to_s, :transaction => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested transaction" do
      transaction = Transaction.create! valid_attributes
      expect {
        delete :destroy, :id => transaction.id.to_s
      }.to change(Transaction, :count).by(-1)
    end

    it "redirects to the transactions list" do
      transaction = Transaction.create! valid_attributes
      delete :destroy, :id => transaction.id.to_s
      response.should redirect_to(transactions_url)
    end
  end

end
