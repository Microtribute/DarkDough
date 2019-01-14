module TransactionsHelper
  def percentage(amount)
    (sprintf("%.3f", amount).to_f * 100)
  end

  def transactions_categories(transactions)
    transactions.map{ |transaction| transaction.category }.uniq
  end

  def transactions_months(transactions)
    transactions.map{ |transaction| transaction.created_at.month }.uniq.sort
  end

  def transactions_descriptions(transactions)
    transactions.map{ |transaction| transaction.description }.uniq.sort
  end

  def categorized(transactions)
    categorized_transactions = []
    (transactions_categories(transactions)).each do |category|
      categorized_transactions << [category, transactions.find_all{|tr| tr.category == category}.map(&:amount).sum.to_f]
    end
    categorized_transactions = Hash[*categorized_transactions.flatten!]
  end

  def monthly(transactions)
    monthly_transactions = []
    (transactions_months(transactions)).each do |month|
      monthly_transactions << [month, transactions.find_all{ |tr| tr.created_at.month == month}.map(&:amount).sum.to_f]
    end
    monthly_transactions = Hash[*monthly_transactions.flatten!]
  end

  def merchanized(transactions)
    merchanized_transactions = []
    (transactions_descriptions(transactions)).each do |description|
      merchanized_transactions << [description, transactions.find_all{ |tr| tr.description == description }.map(&:amount).sum.to_f]
    end
    merchanized_transactions = Hash[*merchanized_transactions.flatten!]
  end
end
