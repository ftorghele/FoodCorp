class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show]

  def index
    redirect_to root_path
  end

  def show
    @meals = Meal.find(:all, :conditions => ["user_id = ?", params[:id]])
    
    @meal =  MealArrangement.find(:all, :conditions => ["meal_id = ?", @meals.first ])

  end

  protected
  def get_user
    if @user = User.find(:first, :conditions => [ "id = ?", params[:id]])
    else
      redirect_to root_path
    end
  end
end
