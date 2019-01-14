class ContactUsController < ApplicationController
  def new
    @title = "Contact us - Budget 24/7"
    @contact_us = ContactUs.new
  end

  def create
    @contact_us = ContactUs.new(params[:contact_us])
    if !@contact_us.valid?
      render :new
    else
      @contact_us.save!
      UserMailer.contact_us(@contact_us).deliver
      redirect_to root_url, :notice => "Email was successfully sent"
    end
  end
end
