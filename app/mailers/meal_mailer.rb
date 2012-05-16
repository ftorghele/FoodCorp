class MealMailer < ActionMailer::Base
  #default :from => current_user.email ? current_user.email : "dinnercollective@com.com"
 
  def notification_email(emitter, receiver, message)
    mail(:from => emitter.email, :to => receiver.email, :subject => message)
  end
end
