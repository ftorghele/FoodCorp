class AjaxController < ApplicationController
  respond_to do
    :js
    :html
  end

  def update_map
    @searchLocation = params[:searchLocation]
    @radius = params[:searchRadius].to_i

    case @radius.to_i
      when 5
              @depth = 15
      when 10
              @depth = 14
      when 15
              @depth = 13
      when 20
              @depth = 12
      else
              @depth = 12
    end

    @lat = params[:searchLat].to_f
    @lon = params[:searchLon].to_f

    unless params[:time].blank?

      date = Date.strptime(params[:time], "%Y-%m-%d").to_datetime
      from = date.beginning_of_day.to_i
      to = date.end_of_day.to_i
      
      @meals = Meal.near([@lat, @lon], @radius).find(:all, :conditions => ["deadline > ? AND time BETWEEN ? AND ?", Time.now.to_datetime.to_i, from, to])
    else
      @meals = Meal.near([@lat, @lon], @radius).find(:all, :conditions => ["deadline > ?", Time.now.to_datetime.to_i])
    end

    @meals.each do |m|
      m.distance = Geocoder::Calculations.distance_between([@lat, @lon], [m.lat, m.lon]) * 1.609344
    end
  end

  def calendar
    currentTime = Time.now.to_datetime.to_i
    futureTime = currentTime + (7*60*60*24)
    @meals = Meal.find(:all, :conditions => ["user_id = ? AND (time > ? AND deadline < ?)", current_user.id, currentTime, futureTime])
    @meal_arrangements = MealArrangement.find(:all, :conditions => ["user_id = ? AND acceptance = 1", current_user.id])

    @user_tasks = []

    @meals.each do |meal|
      @user_tasks << ["meal_id"=>meal.id, "own"=>true, "time"=>meal.time, "title"=>meal.title, "cook"=>meal.user.first_name ]
    end

    @meal_arrangements.each do |meal_arrangement|
      @user_tasks << ["meal_id"=>meal_arrangement.meal_id, "own"=>false, "time"=>meal_arrangement.meal.time, "title"=>meal_arrangement.meal.title, "cook"=>meal_arrangement.meal.user.first_name ]
    end
    @user_tasks.sort! { |a,b| a[0]["time"] <=> b[0]["time"] }
  end
end
