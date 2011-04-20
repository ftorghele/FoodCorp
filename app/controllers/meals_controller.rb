class MealsController < ApplicationController
  
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
   if @meal.update_attributes(:description => params[:meal][:description])
      redirect_to meal_path(meal.id), :notice => "meal updated successfully"
    else
      redirect_to edit_meal_path(meal.id),  :alert => "not valid"
    end

  end
  
  def destroy
    
  end
  
end
