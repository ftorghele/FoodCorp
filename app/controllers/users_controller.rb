class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show, :info]

  def index
    redirect_to root_path
  end

  def info
  end
 
  def show
    @meals = Meal.find(:all, :conditions => ["user_id = ?", params[:id]], :order => 'created_at DESC')
  end
  
  def send_inivation_mail
    user_to_invite = User.find(parmas[:users][:user_id])
    
    MealMailer.notification_email(current_user, user_to_invite, "Cook #{current_user.first_name.concat(' ')<<current_user.last_name} want to invite you").deliver
    redirect_to :back, :notice => I18n.t('user.invitaion_mail_success')
  end
  
  def update 
    user = User.find(params[:user_id])
    if params[:receive_mail]
      user.update_attributes(:mail_notification => true ) 
    else
      user.update_attributes(:mail_notification => false ) 
    end
    
    if user.save
      redirect_to :back, :notice => I18n.t('meal_arrangements.change_success')
    else
	  redirect_to :back, :notice => I18n.t('meal_arrangements.change_fail')
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
