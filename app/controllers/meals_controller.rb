class MealsController < ApplicationController
  
  before_filter :check_login, :only=> [:new, :create, :update, :edit, :destroy]
  before_filter :check_time, :only=> [:create, :update]
  
  def index
   @coords = request.location;
   @user_meals = Meal.find(:all, :conditions => ["user_id = ?", current_user.id]) if current_user
   
   @storred_search_location = cookies[:storred_search_location]
   @storred_search_radius = cookies[:storred_search_radius]
  end

  def new 
    @user = current_user
    @meal = Meal.new
  end 
  
  def show
    @meal = Meal.find(params[:id])
    @meal_arrangement = MealArrangement.where(:meal_id => params[:id], :user_id => current_user.id).first if current_user
    @user = User.find( @meal.user_id )
  end

  def create
    @meal = Meal.new(params[:meal])
    @meal.user_id = current_user.id
    
    if @meal.save
      redirect_to meal_path(@meal.id), :notice => I18n.t('meal.create_success')
    else
      redirect_to new_meal_path  :alert => I18n.t('meal.create_fail')
    end
  end
  
  def edit
    @meal = Meal.where(:id => params[:id], :user_id => current_user.id).first
  end
  
  def update
    @meal = Meal.where(:id => params[:id], :user_id => current_user.id).first
    if @meal.update_attributes(params[:meal])
      redirect_to meal_path(@meal.id), :notice => I18n.t('meal.create_success')
    else
      redirect_to edit_meal_path(@meal.id),  :alert => I18n.t('meal.create_fail')
    end
  end
  
  def destroy
  end

  def create_comment
    meal = Meal.find(params[:meal_id])
    comment = Comment.build_from(meal, current_user.id, params[:body] )
    comment.save
    redirect_to :back
  end

  protected
  def check_login
    unless current_user
      flash[:alert] = I18n.t('application.access_denied')
      redirect_to root_path
    end
  end

  def check_time
    params[:meal][:time] = params[:meal][:time].to_datetime.to_i
    params[:meal][:deadline] = params[:meal][:deadline].to_datetime.to_i

    if(params[:meal][:time] <= Time.now.to_datetime.to_i || params[:meal][:deadline] <= Time.now.to_datetime.to_i || params[:meal][:time] < params[:meal][:deadline])
      redirect_to :back,  :alert => I18n.t('meal.time_fail')
    end
  end
end
