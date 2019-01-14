class RegistrationsController < Devise::RegistrationsController
	include ApplicationHelper
	def create
		phone_number = params[:user][:phone_number]
		sms = params[:user][:sms]
		is_success = true

		if !verify_recaptcha
			flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
			flash.delete :recaptcha_error
			is_success = false
		end
		
		if is_success
			if !send_sms(phone_number, sms)
				flash.now[:alert] = "There was an error while sending the sms to your phone. Please check again."
				flash.delete :recaptcha_error
				is_success = false
			end
		end
		
		if is_success == false
			build_resource
			clean_up_passwords(resource)
			render :new
		else
			flash[:is_signedup] = true
			super
		end
	end
	
end

