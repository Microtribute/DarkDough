module ApplicationHelper
  def title
    site_title = "Budget 24/7"
    @title.nil? ? "#{site_title}" : "#{@title}"
  end

  def acumen_test_menu(user, html_class="")
    if !user.acumen_tests.any?
      link_to "Pass Acumen Test", new_acumen_test_path, :class => html_class
    elsif !user.acumen_tests.last.finished == true
      link_to "Complete test to earn points", edit_acumen_test_path(user.acumen_tests.last), :class => html_class
    elsif user.acumen_tests.last.finished?
      link_to "Acumen Test Result", acumen_test_path(user.acumen_tests.last), :class => html_class
    end
  end
  
  def activated_if(cond)
    if cond
      'activated'
    end
  end

  def current_page_menu(controller_name)
    if controller.controller_name == controller_name
      'active'
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def considering_the_sign(amount)
    amount > 0 ? "positive-val" : "negative-val"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # for acumen test drag'n'drop elements
  def number_to_class(index)
    case index
    when 0
      return 'first'
    when 1
      return 'second'
    when 2
      return 'third'
    end
  end


	def sms
		o =  [('a'..'z'), ('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
		sms = (0..4).map{ o[rand(o.length)] }.join
	end

	
end
