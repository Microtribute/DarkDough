class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_account

  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html
      format.json { render :json => @transactions }
      format.csv { export_to_csv }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @transaction }
    end
  end

  def new
    @transaction = Transaction.new
    respond_to do |format|
      format.html
      format.json { render :json => @transaction }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @accounts = current_user.accounts.all
  end

  def create
    @transaction = current_user.transactions.build(params[:transaction])
    respond_to do |format|
      if @transaction.save
        format.html do
          if budget_by_transaction(@transaction) && transaction_higher_budget?(@transaction)
            UserMailer.budget_exceed(current_user, @budget).deliver
            redirect_to @transaction,
                        :notice => 'Transaction was successfully created.',
                        :alert => "Your budget with '#{@transaction.category}' category is exceeded."
          else
            redirect_to @transaction, :notice => 'Transaction was successfully created.'
          end
        end
        format.json { render :json => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :new }
        format.json { render :json => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html do
          if budget_by_transaction(@transaction) && transaction_higher_budget?(@transaction)
            UserMailer.budget_exceed(current_user, @budget).deliver
            redirect_to @transaction,
                        :notice => 'Transaction was successfully updated.',
                        :alert => "Your budget with '#{@transaction.category}' category is exceeded."
          else
            redirect_to @transaction, :notice => 'Transaction was successfully updated.'
         end
        end
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :ok }
    end
  end

  private

  def find_account
    redirect_to new_account_path unless current_user.accounts.any?
  end

  def budget_by_transaction(transaction)
    @budget = current_user.budgets.find_by_category(transaction.category)
  end

  def transaction_higher_budget?(transaction)
    if budget_by_transaction(transaction)
      budget_by_transaction(transaction).amount < transaction.amount
    end
  end

  protected

  def export_to_csv
    @transactions = Transaction.find(:all, :order => "category ASC")
    @outfile = "transactions_" + I18n.l(Time.now, :format => :short) + ".csv"
    csv_data = FasterCSV.generate(:force_quotes  => true) do |csv|
      csv << [
        "Category",
        "Amount",
        "Created",
        "Description",
        "Note"
      ]
      @transactions.each do |transaction|
        csv << [
          transaction.category,
          transaction.amount,
          transaction.created_at,
          transaction.description,
          transaction.note
        ]
      end
    end

    send_data csv_data, :type => 'text/csv; charset=utf-8;'
  end
end
