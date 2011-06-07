class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show, :info]

  def index
    redirect_to root_path
  end

  def info
  end

  def show
    @meals = Meal.find(:all, :conditions => ["user_id = ?", params[:id]], :order => 'created_at DESC')
   # @meal_arrangements = MealArrangement.find(:all, :conditions => ["user_id = ? AND acceptance = 1", params[:id]])    
  end

  def create_comment
      meal = Meal.find(params[:meal_id])
      meal_arrangement = MealArrangement.where("acceptance = 1 AND meal_id = ? AND user_id = ?", meal.id,  current_user.id ).count
      unless meal_arrangement == 0
        comment = Comment.build_from(meal, current_user.id, params[:body] )
        comment.save
        redirect_to :back
      else
        redirect_to :back,  :alert => I18n.t('application.rights_fail')
      end
  end

  protected
  def get_user
    if @user = User.find(:first, :conditions => [ "id = ? || id = ?", params[:id], params[:user_id]])
    else
      redirect_to root_path
    end
  end
end
