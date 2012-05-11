class MealMailer < ActionMailer::Base
  default :from => current_user.email ? current_user.email : "dinnercollective@com.com"
 
  def notification_email(user, answer)
    mail(:to => user.email, :subject => answer)
  end
end
