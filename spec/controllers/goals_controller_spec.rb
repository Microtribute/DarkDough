require 'spec_helper'

describe GoalsController do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @valid_attributes = { :title => "Factory goal", :category => "Other",
                          :amount => "2000", :contribution => "200",
                          :planned_date => Date.today + 1.year, :user_id => @user }
  end

  describe "GET index" do
    it "assigns all goals as @goals" do
      goal = Goal.create! @valid_attributes
      get :index
      assigns(:goals).should eq([goal])
    end
  end

  describe "GET show" do
    it "assigns the requested goal as @goal" do
      goal = Goal.create! @valid_attributes
      get :show, :id => goal.id.to_s
      assigns(:goal).should eq(goal)
    end
  end

  describe "GET new" do
    it "assigns a new goal as @goal" do
      get :new
      assigns(:goal).should be_a_new(Goal)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Goal" do
        expect {
          post :create, :goal => @valid_attributes
        }.to change(Goal, :count).by(1)
      end

      it "assigns a newly created goal as @goal" do
        post :create, :goal => @valid_attributes
        assigns(:goal).should be_a(Goal)
        assigns(:goal).should be_persisted
      end

      it "redirects to the created goal" do
        post :create, :goal => @valid_attributes
        response.should redirect_to(Goal.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved goal as @goal" do
        # Trigger the behavior that occurs when invalid params are submitted
        Goal.any_instance.stub(:save).and_return(false)
        post :create, :goal => {}
        assigns(:goal).should be_a_new(Goal)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Goal.any_instance.stub(:save).and_return(false)
        post :create, :goal => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested goal" do
        goal = Goal.create! @valid_attributes
        # Assuming there are no other goals in the database, this
        # specifies that the Goal created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Goal.any_instance.should_receive(:update_attributes).with({'these' => 'params', 'account_ids' => []})
        put :update, :id => goal.id, :goal => {'these' => 'params'}
      end

      it "assigns the requested goal as @goal" do
        goal = Goal.create! @valid_attributes
        put :update, :id => goal.id, :goal => @valid_attributes
        assigns(:goal).should eq(goal)
      end

      it "redirects to the goal" do
        goal = Goal.create! @valid_attributes
        put :update, :id => goal.id, :goal => @valid_attributes
        response.should redirect_to(goal)
      end
    end

    describe "with invalid params" do
      it "assigns the goal as @goal" do
        goal = Goal.create! @valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Goal.any_instance.stub(:save).and_return(false)
        put :update, :id => goal.id.to_s, :goal => {}
        assigns(:goal).should eq(goal)
      end

      it "re-renders the 'edit' template" do
        goal = Goal.create! @valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Goal.any_instance.stub(:save).and_return(false)
        put :update, :id => goal.id.to_s, :goal => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested goal" do
      goal = Goal.create! @valid_attributes
      expect {
        delete :destroy, :id => goal.id.to_s
      }.to change(Goal, :count).by(-1)
    end

    it "redirects to the goals list" do
      goal = Goal.create! @valid_attributes
      delete :destroy, :id => goal.id.to_s
      response.should redirect_to(goals_url)
    end
  end

end
