class UsersController < ApplicationController
	include ApplicationHelper
	skip_before_filter :verify_authenticity_token, :confirmationp
  before_filter :authenticate_user!, :except=>[:confirmation,:socialsignin,:verification]
  before_filter :check_account, :except=>[:confirmation,:socialsignin,:verification]

  def show
    @title = 'Profile - Budget 24/7'
    params[:user] ? @user = current_user.update_attributes(params[:user]) : @user = current_user
    @accounts = current_user.accounts
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "Profile updated"
    else
      render 'edit'
    end
  end
	
	def confirmation
		redirect_to root_path if !params[:confirmation_token]
		@confirmation_token = params[:confirmation_token]
		user = User.find_by_confirmation_token(@confirmation_token)
		redirect_to root_path unless user
	end
	
	def socialsignin
		url = "https://rpxnow.com/api/v2/auth_info"
		content = "token=#{params['token']}&apiKey=#{JR_API_KEY}"
		response = http_post(url, content)
		response = JSON.parse(response)
		if response["err"]
			flash.now[:alert] = "There was an error occurred while sigining in via Social Link. Please try again later."
			redirect_to root_path and return
		else
			phone_number = params[:phone_number]
			response = response["profile"]
			profile = response["profile"]
			name = response["name"]
			user = User.find_by_email(response["email"])
			_sms = sms
			if user==nil
				user = User.create
				unless response["name"].nil?
					name = response["name"]
					user.email = response["email"]
					user.first_name = name["givenName"]
					user.last_name = name["familyName"] || name["givenName"]
					user.age = 'undef'
					user.gender = 'Unspecified'
					user.country = 'Afghanistan'
					user.phone_number = phone_number
					user.sms = _sms
				end
				phone_number = phone_number.gsub(/[^0-9]/,'')
				if !send_sms(phone_number, _sms)
					flash[:alert] = "There was an error while sending the sms to your phone #{phone_number}. Please check again."
					redirect_to root_path and return
				end
				user.save
				flash[:is_signedup] = true
				redirect_to root_path and return
			else
				sign_in(:user, user) and redirect_to root_path and return
			end
		end
	end
	
	def verification
		param = params[:user]
		redirect_to root_path if !param[:confirmation_token]
		confirmation_token = param[:confirmation_token]

		user = User.find_by_confirmation_token(confirmation_token)
		unless user
			flash[:error] = "Invalid SMS code"
			redirect_to confirmation_path+"?confirmation_token="+confirmation_token and return
		end

		user.confirmed_at = Time.now
		user.password = param[:password]
		user.confirmation_token = nil
		user.sms = nil
		user.save
		sign_in user and redirect_to dashboard_path
	end
	

  private

  def check_account
    redirect_to '/accounts/new' unless current_user.accounts.any?
  end
end
