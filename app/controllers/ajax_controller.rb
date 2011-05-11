class AjaxController < ApplicationController
  respond_to :js

  def update_map
    @searchLocation = params[:searchLocation]
    @radius = params[:radius]
  end

  def calendar
    currentTime = Time.now.to_datetime.to_i
    futureTime = currentTime + (7*60*60*24)
    @meals = Meal.find(:all, :conditions => ["user_id = ? AND (time > ? AND deadline < ?)", current_user.id, currentTime, futureTime])
    @meal_arrangements = MealArrangement.find(:all, :conditions => ["user_id = ? AND acceptance = 1", current_user.id])

    @user_tasks = []

    @meals.each do |meal|
      @user_tasks << ["meal_id"=>meal.id, "flag"=>true, "time"=>meal.time ]
    end

    @meal_arrangements.each do |meal_arrangement|
      @user_tasks << ["meal_id"=>meal_arrangement.meal_id, "flag"=>false, "time"=>meal_arrangement.meal.time ]
    end
    @user_tasks.sort! { |a,b| a[0]["time"] <=> b[0]["time"] }

  end
end
