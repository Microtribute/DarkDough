class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  
  layout Proc.new { |controller| controller.request.xhr? ? 'popup' : 'application' }

  def index
    @title = 'Budgets - Budget 24/7'
    # @budget = Budget.new(:budget_type => 'income')
    @budgets =  current_user.budgets.search(params[:budgets_start], params[:budgets_end])

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @budgets }
    end
  end

  def show
    @budget = Budget.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @budget }
    end
  end

  def new
    @budget = Budget.new(budget_type: params[:budget_type])
    
    respond_to do |format|
      format.html
      format.json { render :json => @budget }
    end
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def create
    @budget = current_user.budgets.build params[:budget]
    
    @budget.amount = -@budget.amount if @budget.budget_type == 'spending'
    
    respond_to do |format|
      if @budget.save
        format.html { redirect_to budgets_path(budget_type: @budget.budget_type), :notice => 'Budget was successfully created.' }
        format.json { render :json => @budget, :status => :created, :location => @budget }
      else
        format.html { render :action => "new" }
        format.json { render :json => @budget.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @budget = Budget.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to budgets_path, :notice => 'Budget was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @budget.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :ok }
    end
  end
end
