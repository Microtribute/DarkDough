require 'spec_helper'

describe BudgetsController do

  def valid_attributes
    {:category => "Phone", :amount => "1234", :period => "1", :user_id => '1'}
  end

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all budgets as @budgets" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested budget as @budget" do
      budget = Budget.create! valid_attributes
      get :show, :id => budget.id.to_s
      assigns(:budget).should eq(budget)
    end
  end

  describe "GET new" do
    it "assigns a new budget as @budget" do
      get :new
      assigns(:budget).should be_a_new(Budget)
    end
  end

  describe "GET edit" do
    it "assigns the requested budget as @budget" do
      budget = Budget.create! valid_attributes
      get :edit, :id => budget.id.to_s
      assigns(:budget).should eq(budget)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Budget" do
        expect {
          post :create, :budget => valid_attributes
        }.to change(Budget, :count).by(1)
      end

      it "assigns a newly created budget as @budget" do
        post :create, :budget => valid_attributes
        assigns(:budget).should be_a(Budget)
        assigns(:budget).should be_persisted
      end

      it "redirects to the created budget" do
        post :create, :budget => valid_attributes
        response.should redirect_to(budgets_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved budget as @budget" do
        # Trigger the behavior that occurs when invalid params are submitted
        Budget.any_instance.stub(:save).and_return(false)
        post :create, :budget => {}
        assigns(:budget).should be_a_new(Budget)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Budget.any_instance.stub(:save).and_return(false)
        post :create, :budget => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested budget" do
        budget = Budget.create! valid_attributes
        # Assuming there are no other budgets in the database, this
        # specifies that the Budget created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Budget.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => budget.id, :budget => {'these' => 'params'}
      end

      it "assigns the requested budget as @budget" do
        budget = Budget.create! valid_attributes
        put :update, :id => budget.id, :budget => valid_attributes
        assigns(:budget).should eq(budget)
      end

      it "redirects to the budget" do
        budget = Budget.create! valid_attributes
        put :update, :id => budget.id, :budget => valid_attributes
        response.should redirect_to(budgets_url)
      end
    end

    describe "with invalid params" do
      it "assigns the budget as @budget" do
        budget = Budget.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Budget.any_instance.stub(:save).and_return(false)
        put :update, :id => budget.id.to_s, :budget => {}
        assigns(:budget).should eq(budget)
      end

      it "re-renders the 'edit' template" do
        budget = Budget.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Budget.any_instance.stub(:save).and_return(false)
        put :update, :id => budget.id.to_s, :budget => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested budget" do
      budget = Budget.create! valid_attributes
      expect {
        delete :destroy, :id => budget.id.to_s
      }.to change(Budget, :count).by(-1)
    end

    it "redirects to the budgets list" do
      budget = Budget.create! valid_attributes
      delete :destroy, :id => budget.id.to_s
      response.should redirect_to(budgets_url)
    end
  end

end
