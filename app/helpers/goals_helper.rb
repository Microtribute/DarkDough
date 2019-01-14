module GoalsHelper
  def check_account_dedicated(account)
    user_accounts_ids = []
    current_user.goals.each do |goal|
      user_accounts_ids << goal.account_ids
    end
    user_accounts_ids = user_accounts_ids.uniq.flatten
    user_accounts_ids.include?(account.id) ? true : false
  end

  def render_goal_form(type)
      render partial: "/goals/types/#{type}"
  end

  def edit_goal(goal)
    if Goal::GOAL_PREDEFINED_CATEGORIES.include?(goal.category)
      link_to 'Edit', edit_goal_path(goal, type: goal.category.parameterize.underscore.to_sym)
    else
      link_to 'Edit', edit_goal_path(goal)
    end
  end
end
