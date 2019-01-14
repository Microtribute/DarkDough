class UserMailer < ActionMailer::Base
	default from: "WarmWelcome@budget247.com"
	
  def contact_us(contact_us)
    mail :to => "pfm.sup.psodhfoih2904@gmail.com",
         :from => "#{contact_us.full_name} #{contact_us.email}",
         :content_type => 'text/html',
         :subject => "PFM support request",
         :body => "Name: #{contact_us.full_name}<br/>" +
                  "Email: #{contact_us.email}<br/><br/>" +
                  contact_us.text
  end

  def budget_exceed(user, budget)
    @user = user
    @budget = budget
    mail :to => user.email,
         :from => "pfm.sup.psodhfoih2904@gmail.com",
         :content_type => 'text/html',
         :subject => "Budget 24-7 | Your budget is exceeded"
  end

  def testmail
    mail :to => 'jinnahrae@gmail.com',
         :from => "WarmWelcome@budget247.com",
         :content_type => 'text/html',
         :subject => "Budget 24-7 | Your budget is exceeded",
				 :body => 'Hi, there!'
  end

end
