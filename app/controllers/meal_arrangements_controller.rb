class MealArrangementsController < ApplicationController

  before_filter :get_meal, :only => [:edit, :show, :update, :destroy]
  before_filter :get_invite_user, :only => [:update, :destroy]
  before_filter :check_user, :only => [:update]
  before_filter :check_points, :only => [:create]

  def create # user_id form meal_a is user that wants to eat at someone's place
      @meal_arrangement = MealArrangement.new(:user_id => current_user.id,
                                              :meal_id => params[:meal_id],
                                              :acceptance => false,
                                              :mail_notification => params[:receive_meal].to_i)
      if @meal_arrangement.save
        redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.create_success')
        current_user.points -= 1
        current_user.update_attribute(:points, current_user.points)
      else
        redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.create_fail')
      end
  end

  def update
    current_meal_id = @meal_arrangement.meal_id
    if current_user.id == @meal_arrangement.meal.user_id #Cook
      if @meal_arrangement.update_attribute(:acceptance, true)
		
		# yes you can
		MealMailer.notification_email(current_user, @user_to_invite, "Cook invite you").deliver
		
        current_user.points += 1
        meal = Meal.find(current_meal_id)
        meal.slots -= 1
        meal.save

        current_user.update_attribute(:points, current_user.points)
        current_user.send_message(@meal_arrangement.user, I18n.t('message.accept', :title => meal.title), I18n.t("message.info") )
        redirect_to :back, :notice => I18n.t('meal_arrangements.accept_success')
      else
          redirect_to :back, :notice => I18n.t('meal_arrangements.accept_fail')
      end
    end
  end
  
  def destroy
    if current_user.id == @meal_arrangement.meal.user_id #Cook
      if @meal_arrangement.destroy
      
        # yes you can not!
        MealMailer.notification_email(current_user, @user_to_invite, "Cook disinvite you").deliver

        @meal_arrangement.user.points += 1
        @meal_arrangement.user.update_attribute(:points, @meal_arrangement.user.points)
        current_user.send_message(@meal_arrangement.user, I18n.t('message.reject', :title => @meal_arrangement.meal.title), I18n.t('message.sorry') )
        redirect_to :back, :notice => I18n.t('meal_arrangements.delete_success')
      else
        redirect_to :back, :notice => I18n.t('meal_arrangements.delete_fail')
      end
    elsif current_user.id == @meal_arrangement.user_id #Eater
      unless @meal_arrangement.acceptance
        if @meal_arrangement.destroy
          @meal_arrangement.user.points += 1
          @meal_arrangement.user.update_attribute(:points, @meal_arrangement.user.points)
          redirect_to :back, :notice => I18n.t('meal_arrangements.delete_success')
        else
          redirect_to :back, :notice => I18n.t('meal_arrangements.delete_fail')
        end
      else
        redirect_to :back, :notice => I18n.t('meal_arrangements.acceptance_given_fail')
      end
    else
      redirect_to root_path, :notice => I18n.t('application.rights_fail')
    end
  end

  private

  def check_points
    if current_user.points < -2
      redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.point_fail')
    end
  end

  def get_meal
    @meal_arrangement = MealArrangement.find(params[:id])
  end

  def check_user
    unless current_user.id == @meal_arrangement.meal.user_id
      redirect_to root_path, :notice => I18n.t('application.rights_fail')
    end
  end
  
  def get_invite_user
    @user_to_invite = User.find( @meal_arrangement.user_id )
  end
end
