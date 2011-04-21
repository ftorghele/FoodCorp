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
    @meal_arrangement = MealArrangement.new(:user_id => current_user.id , :meal_id => params[:meal_id], :acceptance => false)


      if @meal_arrangement.save
        redirect_to meal_path(params[:meal_id]), :notice => 'Meal arrangement was successfully created.' 
      else
        redirect_to meal_path(params[:meal_id]), :notice => "meal arrengement failed"
      end
  end


  def update
    @meal_arrangement = MealArrangement.find(params[:id])
    
    #if current_user.id == @meal_arrangement.meal.user_id
      if @meal_arrangement.update_attributes(:acceptance => true)
          redirect_to user_path(current_user.id), :notice => 'Meal arrangement accepted.' 
        else
          redirect_to user_path(current_user.id), :notice => "meal arrengement acceptance failed"
      end
   # else
    #  redirect_to root_path, :notice=> "no rights for this action"
    #end
  end


  def destroy
    @meal_arrangement = MealArrangement.find(params[:id])
    
    if current_user.id == @meal_arrangement.meal.user_id
      if @meal_arrangement.destroy
        redirect_to user_path(current_user.id), :notice => 'Meal arrangement was successfully deleted.' 
      else
          redirect_to user_path(current_user.id), :notice => "meal arrengement delete failed"
      end
    else
      redirect_to root_path, :notice => "no rights for this action"
    end
  end

end
