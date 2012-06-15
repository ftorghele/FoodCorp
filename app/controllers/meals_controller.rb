require 'rss/1.0'
require 'rss/2.0'

class MealsController < ApplicationController

  before_filter :check_login, :only=> [:new, :create, :update, :edit, :destroy]
#  before_filter :check_time, :only=> [:create, :update]
  before_filter :get_meal, :only=> [:edit, :update]
  before_filter :get_user, :only => [:create_current_user_location, :update_current_user_location]
  
  def index
   @coords = request.location;
   @user_meals = Meal.find(:all, :conditions => ["user_id = ? AND time >=" << Time.now.to_i.to_s, current_user.id]) if current_user

   @storred_search_location = cookies[:storred_search_location]
   @storred_search_radius = cookies[:storred_search_radius]
   
   if current_user
     if current_user.current_user_location
       @current_user_location = User.find(current_user.id).current_user_location
     else
       @current_user_location = CurrentUserLocation.new
     end
   else
     @current_user_location = nil
   end
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
			@meal.user.meal_counter += 1
			@meal.user.save
			
      redirect_to meal_path(@meal.id), :notice => I18n.t('meal.create_success')
    else
      redirect_to new_meal_path,  :alert => I18n.t('meal.create_fail')
    end
  end

  def edit
  end

  def update
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
  
  def create_current_user_location
    @current_user_location = CurrentUserLocation.create(params[:current_user_location])
    @current_user_location.user_id = current_user.id
    
    if @current_user_location.save
      redirect_to :back, :notice => I18n.t('current_user_location.create_success')
    else
      redirect_to :back, :notice => I18n.t('current_user_location.create_fail')
    end
  end
  
  def update_current_user_location
    if User.find(params[:user_id]).current_user_location.update_attributes(params[:current_user_location])
      redirect_to :back, :notice => I18n.t('current_user_location.update_success')
    else
      redirect_to :back, :notice => I18n.t('current_user_location.update_fail')
    end
  end
  
  def recipes
    @recipes_array = []
    rss_recipes = RSS::Parser.parse('http://www.recipetips.com/cooking-feed/recipes/easy-dinners.xml', false)
    
    for i in 0...rss_recipes.items.count do
      recipe = []
      
      recipe << rss_recipes.items[i].title
      
      description = rss_recipes.items[i].description
      num = description.index '.'
      recipe << description[0..num]
      
      photoStart = description.index 'src=\''
      photoEnd = description.index '\'', (photoStart+6)
      recipe << description[(photoStart+5)...photoEnd]
      
      recipe << rss_recipes.items[i].link.to_s
      
      @recipes_array << recipe
    end
  end
  
  protected
  def check_login
    unless current_user
      flash[:alert] = I18n.t('application.access_denied')
      redirect_to root_path
    end
  end

  

  def get_meal
    @meal = Meal.where(:id => params[:id], :user_id => current_user.id).first
  end
  
  def get_user
    @user = User.find(params[:user_id])
  end
end
