class MealsController < ApplicationController
  def index
   @meals = Meal.all
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
    meal.save!
      redirect_to meal_path(meal.id), :notice => "meal created successfully"


  end
  
  def edit
    @meal = Meal.find(params[:id])
  end
  
  def update
    
  end
end
