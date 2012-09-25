class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show, :info]

  def index
    redirect_to root_path
  end

  def info
  end
 
  def show
    @meals = Meal.find(:all, :conditions => ["user_id = ?", params[:id]], :order => 'created_at DESC')
    @rating = Rating.find(:all)
  end
  
  def update 
    if params[:user_id] # wants to get mails?
      user = User.find(params[:user_id])
      if params[:user] && params[:user][:mail_notification] # in user's profile
        user.update_attributes(:mail_notification => params[:user][:mail_notification] ) 
      end
      
      if params[:receive_mail] # in show meal
        if params[:receive_mail] == '1'
		  user.update_attributes(:mail_notification => true ) 
        else
          user.update_attributes(:mail_notification => false ) 
        end
      end
      redirect_to :back, :notice => 'Mail Notifications updated'
    end
    
    if params['users'] # send invitation mail
      if params['users']['user_id'] 
        user_to_invite = User.find(params['users']['user_id'])
        
        if user_to_invite.mail_notification
          MealMailer.notification_email(current_user, user_to_invite, "Cook #{current_user.first_name.concat(' ')<<current_user.last_name} want to invite you").deliver
        end
        
        user_to_invite.update_attributes( :got_invitation => true )
        
        redirect_to user_path(current_user.id), :notice => I18n.t('user.invitaion_mail_success')
      else
        redirect_to user_path(current_user.id), :notice => I18n.t('user.invitaion_mail_fail')
      end
    end
  end
  
  protected
  def get_user
    if @user = User.find(:first, :conditions => [ "id = ? || id = ?", params[:id], params[:user_id]])
    else
      redirect_to root_path
    end
  end
end
