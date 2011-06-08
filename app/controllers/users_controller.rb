class UsersController < ApplicationController

  before_filter :get_user, :only=> [:show, :info]

  def index
    redirect_to root_path
  end

  def info
  end

  def show
    @meals = Meal.find(:all, :conditions => ["user_id = ?", params[:id]], :order => 'created_at DESC')
  end

  protected
  def get_user
    if @user = User.find(:first, :conditions => [ "id = ? || id = ?", params[:id], params[:user_id]])
    else
      redirect_to root_path
    end
  end
end
