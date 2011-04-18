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
    @meal = Meal.new(:title => params[:title], :description => params[:description], 
                     :user_id => params[:user_id], :time => params[:time], :deadline => params[:deadline],
                     :lon => params[:lon], :lat => params[:lat] )
   
    if @meal.save
      redirect_to meal_path(@meal.id), :notice => "meal created successfully"
    else
      render 'new'
    end 
  end
  
  def edit
    @meal = Meal.find(params[:id])
  end
  
  def update
    
  end
end
