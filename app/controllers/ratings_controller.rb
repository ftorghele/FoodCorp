class RatingsController < ApplicationController

  before_filter :get_meal, :only => [:edit, :show, :update, :destroy]

  def new
    @user = current_user
    @meal = Meal.find(params[:id])
    @rating = Rating.new
  end
  
  def create # user_id form meal_a is user that wants to eat at someone's place
      @rating = Rating.new(params[:rating])
      @rating.user_id = current_user.id
      @rating.meal_id = params[:meal_id]
      
      @rating.save
      if @rating.save
		redirect_to "/meals/#{@rating.meal_id}/#{@rating.rating}", :notice => "Speichern erfolgreich"
	  else
		redirect_to meals_path(@rating.meal_id), :notice => "Speichern fehlgeschlagen"
	  end
  end

  private


  def get_meal
    @rating = Rating.find(params[:id])
  end

end
