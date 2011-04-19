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
    @meal_arrangement = MealArrangement.new(:user_id => params[:user_id], :meal_id => params[:meal_id])


      if @meal_arrangement.save
        redirect_to(@meal_arrangement, :notice => 'Meal arrangement was successfully created.') 
      else
        redirect_to root_path, :notice => "meal arrengement fails"
      end
  end


  def update
    @meal_arrangement = MealArrangement.find(params[:id])
  end


  def destroy
    @meal_arrangement = MealArrangement.find(params[:id])
    @meal_arrangement.destroy
  end

end
