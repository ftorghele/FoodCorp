class FellowshipsController < ApplicationController
  def create
    @fellowship = current_user.fellowships.build(:follower_id => params[:follower_id])
    if @fellowship.save
      flash[:notice] = "following.."
      redirect_to :back
    else
      flash[:alert] = "Unable to follow"
      redirect_to :back
    end
  end

  def destroy
    @fellowship = current_user.fellowships.find(params[:id])
    @fellowship.destroy
    flash[:notice] = "Removed fellowship."
    redirect_to :back
  end
end
