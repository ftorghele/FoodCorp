class MealArrangementsController < ApplicationController

  def index
    @meal_arrangements = MealArrangement.all
  end


  def show
    @meal_arrangement = MealArrangement.find(params[:id])
  end


  def new
    @meal_arrangement = MealArrangement.new
  end


  def edit
    @meal_arrangement = MealArrangement.find(params[:id])
  end

  def create
    @meal_arrangement = MealArrangement.new(:user_id => current_user.id , :meal_id => params[:meal_id])


      if @meal_arrangement.save
        redirect_to meal_path(params[:meal_id]), :notice => 'Meal arrangement was successfully created.' 
      else
        redirect_to meal_path(params[:meal_id]), :notice => "meal arrengement fails"
      end
  end


  def update
    @meal_arrangement = MealArrangement.find(params[:id])
  end


  def destroy
    @meal = MealArrangement.find(:all, :conditions => { :user_id => current_user.id, :meal_id => params[:meal_id]}) 
    if @meal[0].destroy
      redirect_to meal_path(params[:meal_id]), :notice => 'Meal arrangement was successfully deleted.' 
    else
        redirect_to meal_path(params[:meal_id]), :notice => "meal arrengement delete fails"
    end
  end

end
