class PagesController < HighVoltage::PagesController
  before_filter :authenticate_user!, only: :help_create_account
  before_filter :redirect_signed_in_user, only: 'home'
  before_filter :set_title

  layout 'public'
	
private
  def set_title
    @title = case params[:id]
    when 'about'
      "About - Budget 24/7"
    when 'how_it_works'
      "How it works - Budget 24/7"
    when 'faq'
      "FAQ - Budget 24/7"
    when 'terms_of_use'
      "Terms of use - Budget 24/7"
    when 'help_create_account'
      "Help create account - Budget 24/7"
    else
      "Budget 24/7"
    end
  end

  def redirect_signed_in_user
    if current_user
      redirect_to dashboard_path
    end
  end
end
