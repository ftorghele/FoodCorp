class MealArrangementsController < ApplicationController

  before_filter :get_meal, :only => [:edit, :show, :update, :destroy]
  before_filter :check_user, :only => [:update]

  def create
    if current_user.points > -2
      @meal_arrangement = MealArrangement.new(:user_id => current_user.id,
                          :meal_id => params[:meal_id],
                          :acceptance => false)

      if @meal_arrangement.save
        redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.create_success')
        current_user.points -= 1
        current_user.update_attribute(:points, current_user.points)
        
      else
        redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.create_fail')
      end
    
    else 
      redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_arrangements.point_fail')
    end
  end

  def update
    current_meal_id = @meal_arrangement.meal_id
    if @meal_arrangement.update_attribute(:acceptance, true)
        current_user.points += 1
        meal = Meal.find(current_meal_id)
        meal.slots -= 1
        meal.save
        current_user.update_attribute(:points, current_user.points)
        puts(current_user.points)
        current_user.send_message(@meal_arrangement.user, I18n.t('message.accept'), I18n.t('message.info') )
        redirect_to :back, :notice => I18n.t('meal_arrangements.accept_success')
    else
        redirect_to :back, :notice => I18n.t('meal_arrangements.accept_fail')
    end
  end

  def destroy
    if current_user.id == @meal_arrangement.meal.user_id #Cook
      if @meal_arrangement.destroy
        @meal_arrangement.user.points += 1
        @meal_arrangement.user.update_attribute(:points, @meal_arrangement.user.points)
        current_user.send_message(@meal_arrangement.user, I18n.t('message.reject'), I18n.t('message.sorry') )
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
  def get_meal
    @meal_arrangement = MealArrangement.get_meal_arrangement params[:id]
  end

  def check_user
    unless current_user.id == @meal_arrangement.meal.user_id
      redirect_to root_path, :notice => I18n.t('application.rights_fail')
    end
  end

end
