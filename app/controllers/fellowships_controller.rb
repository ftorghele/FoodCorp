class FellowshipsController < ApplicationController
  def create
    @fellowship = current_user.fellowships.build(:follower_id => params[:follower_id])
    if @fellowship.save
      flash[:notice] = I18n.t('fellowships.create_success')
      redirect_to :back
    else
      flash[:alert] = I18n.t('fellowships.create_fail') 
      redirect_to :back
    end
  end

  def destroy
    @fellowship = current_user.fellowships.find(params[:id])
    if @fellowship.destroy
      flash[:notice] = I18n.t('fellowships.destroy_success') 
      redirect_to :back
    else
      flash[:notice] = I18n.t('fellowships.destroy_fail') 
      redirect_to :back
    end
  end
end
