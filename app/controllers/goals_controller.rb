class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "Goals - Budget 24/7"
    @goals = Goal.all

    respond_to do |format|
      format.html
      format.json { render :json => @goals }
    end
  end

  def show
    @title = 'The Goal - Budget 24/7'
    @goal = Goal.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @goal }
    end
  end

  def new
    @title = 'New Goal - Budget 24/7'
    @goal = Goal.new

    respond_to do |format|
      format.html
      format.json { render :json => @goal }
    end
  end

  def edit
    @title = 'Edit Goal - Budget 24/7'
    @goal = current_user.goals.find(params[:id])
  end

  def create
    @goal = current_user.goals.new(params[:goal])

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, :notice => 'Goal was successfully created.' }
        format.json { render :json => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.json { render :json => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    params[:goal][:account_ids] ||= []
    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to @goal, :notice => 'Goal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :ok }
    end
  end

  def select
      @title = 'New Goal - Budget 24/7'
  end
end
