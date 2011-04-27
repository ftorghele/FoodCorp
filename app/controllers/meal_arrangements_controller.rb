class MealArrangementsController < ApplicationController

  before_filter :get_meal, :only => [:edit, :show, :update, :destroy]
  before_filter :check_user, :only => [:edit, :update, :destroy]

  def index
    @meal_arrangements = MealArrangement.all
  end

  def new
    @meal_arrangement = MealArrangement.new
  end

  def create
    @meal_arrangement = MealArrangement.new(:user_id => current_user.id,
                        :meal_id => params[:meal_id],
                        :acceptance => false)

    if @meal_arrangement.save
      redirect_to meal_path(params[:meal_id]), :notice => 'Meal arrangement was successfully created.'
    else
      redirect_to meal_path(params[:meal_id]), :notice => "meal arrengement failed"
    end
  end


  def update
    if @meal_arrangement.update_attribute(:acceptance, true)
        current_user.send_message(@meal_arrangement.user, "Meal arrangement acceptance", "body of msg")
        redirect_to user_path(current_user.id), :notice => 'Meal arrangement accepted.'
      else
        redirect_to user_path(current_user.id), :notice => "meal arrengement acceptance failed"
    end
  end

  def destroy
    if @meal_arrangement.destroy
      current_user.send_message(@meal_arrangement.user, "Meal arrangement rejected", "sorry...")
      redirect_to user_path(current_user.id), :notice => 'Meal arrangement was successfully deleted.'
    else
        redirect_to user_path(current_user.id), :notice => "meal arrengement delete failed"
    end
  end

  private
  def get_meal
    @meal_arrangement = MealArrangement.find(params[:id])
  end

  def check_user
    unless current_user.id == @meal_arrangement.meal.user_id
      redirect_to root_path, :notice => "no rights for this action"
    end
  end

end
