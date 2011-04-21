class MealsController < ApplicationController
  
  require 'date'
  require 'time'
  
  helper MealsHelper
  helper_method :convert
  
  def index
   @meals = Meal.find(:all)
  end

  def new 
    @meal = Meal.new
  end 
  
  def show
    @meal = Meal.find(params[:id])
  end

  def create
    
    meal = Meal.new(params[:meal])
    meal.user_id = current_user.id
    #meal.time.to_datetime().to_i
    #meal.time = meal.time.to_time().to_i
    #meal.deadline = meal.deadline.to_time().to_i
    
    if meal.save
      redirect_to meal_path(meal.id), :notice => "meal created successfully"
    else
      redirect_to new_meal_path,  :alert => "not valid"
    end
  end
  
  def edit
    @meal = Meal.find(params[:id])
  end
  
  def update
      @meal = Meal.find(params[:id])
   if @meal.update_attributes(params[:meal])
      redirect_to meal_path(@meal.id), :notice => "meal updated successfully"
    else
      redirect_to edit_meal_path(@meal.id),  :alert => "not valid"
    end

  end
  
  def destroy
    
  end
  
end
