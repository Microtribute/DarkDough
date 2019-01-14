module BudgetsHelper
  def period_select
    %w(2 3 4 5 6 7 8 9 10 11 12).collect{ |p| [pluralize(p, "month"), p] }
  end
end
