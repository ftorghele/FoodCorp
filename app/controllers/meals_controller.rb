class MealsController < ApplicationController
  
  before_filter :check_time, :only => [:create, :update]
  
  def index
   @meals = Meal.find(:all)
   @coords = request.location;
  end

  def new 
    @meal = Meal.new
  end 
  
  def show
    @meal = Meal.find(params[:id])
    @meal_arrangement = MealArrangement.where(:meal_id => @meal.id, :user_id => current_user.id).first
  end

  def create
    meal = Meal.new(params[:meal])
    meal.user_id = current_user.id
    
    if meal.save
      redirect_to meal_path(meal.id), :notice => I18n.t('meal.create_success')
    else
      redirect_to new_meal_path,  :alert => I18n.t('meal.create_fail')
    end
  end
  
  def edit
    @meal = Meal.find(params[:id])
  end
  
  def update
      @meal = Meal.find(params[:id])
   if @meal.update_attributes(params[:meal])
      redirect_to meal_path(@meal.id), :notice => I18n.t('meal.create_success')
    else
      redirect_to edit_meal_path(@meal.id),  :alert => I18n.t('meal.create_fail')
    end

  end
  
  def destroy
    
  end
  
  private
  def check_time
    
      params[:meal][:time] = params[:meal][:time].to_datetime.to_i
      params[:meal][:deadline] = params[:meal][:deadline].to_datetime.to_i
    
      if(params[:meal][:time] <= Time.now.to_datetime.to_i || params[:meal][:deadline] <= Time.now.to_datetime.to_i) 
      
        redirect_to :back,  :alert => I18n.t('meal.time_fail')
        
      end
      
  end

end
