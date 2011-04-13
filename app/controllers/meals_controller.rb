class MealsController < ApplicationController
  def index
   @meals = meal.all
  end

  def new 
    @meal = meal.new
  end 
  
  def show
    @meal = meal.find(params[:id])
  end

  def create
    @meal = meal.new(params[:meal])

    if @meal.save
      redirect_to meals_path, :notice => "meal erfolgreich angelegt"
    else
      render 'new'
    end 
  end
  
  def edit
    @meal = meal.find(params[:id])
  end
  
  def update
    
  end
end
