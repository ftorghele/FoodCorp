class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show]

  def index
    redirect_to root_path
  end

  def show
    currentTime = Time.now.to_datetime.to_i
    futureTime = currentTime + (7*60*60*24)
    @meals = Meal.find(:all, :conditions => ["user_id = ? AND (time > ? AND deadline < ?)", params[:id], currentTime, futureTime])
    @meal_arrangements = MealArrangement.find(:all, :conditions => ["user_id = ? AND acceptance = 1", params[:id]])
  end

  protected
  def get_user
    if @user = User.find(:first, :conditions => [ "id = ?", params[:id]])
    else
      redirect_to root_path
    end
  end
end
