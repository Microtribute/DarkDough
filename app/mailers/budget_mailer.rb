class BudgetMailer < Devise::Mailer
	def confirmation_instructions(record)
		Devise.mailer_sender = "WarmWelcome@budget247.com"
		super
	end
end