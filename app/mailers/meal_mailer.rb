class MealMailer < ActionMailer::Base
  #default :from => current_user.email ? current_user.email : "dinnercollective@com.com"
 
  def notification_email(emitter, receiver, message)
    recipients receiver.email
    from emitter.email
    subject message
    sent_on Time.now
  end
end
