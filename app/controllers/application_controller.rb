class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    dashboard_path
  end


  def http_get(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    #request.basic_auth("","")
    http.request(request).body
  end

  def http_post(url,content)
    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = content
    #request.basic_auth("","")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request).body
  end


	def send_sms(phone_number,sms)
		phone_number = phone_number.to_s.gsub(/[^0-9]/i,'')
		begin
			File.open("./sms.txt","a") do |f|
				a = {:to => phone_number, :sms => sms}
				f.puts a.inspect
			end
			nexmo = ::Nexmo::Client.new('5915f34a', 'c9c9faa9')
			nexmo.send_message!({:to => phone_number, :from => 'Budget247', :text => "Welcome to budget247!\nHere is your code.\n\n"+sms})
			
			return sms
		rescue Exception=>e
			return nil
		end
	end




  protected

  def layout_by_resource
    if devise_controller?
      "public"
    else
      "application"
    end
  end
end
