class LocationsController < ApplicationController
  before_filter :get_location, :only => [:edit, :update]
  
  def new
    @location = Location.new
  end
	
  def create
    @location = Location.create(params[:location])
    @location.user_id = current_user.id
    
    if @location.save
      redirect_to :root, :notice => I18n.t('current_user_location.create_success')
    else
      redirect_to :back, :notice => I18n.t('current_user_location.create_fail')
    end
  end
  
  def edit
  end
  
  def update
    if @location.update_attributes(params[:location]) && @location.update_attributes(:activate => params[:location][:activate] == '1')
      redirect_to :root, :notice => I18n.t('current_user_location.update_success')
    else
      redirect_to :back, :notice => I18n.t('current_user_location.update_fail')
    end
  end
  
  private
  def get_location
    @location = Location.find(params[:id])
  end
  
end
