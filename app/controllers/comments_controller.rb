class CommentsController < ApplicationController

  before_filter :get_meal_comment, :only => [:edit, :update]
  before_filter :check_user, :only => [:edit]

=begin
	#Meal Arrangement controller on acceptance
	def create
		comment = Comment.new(:user_id => current_user.id, :meal_id => params[:meal_id], :body => params[:body])

		if comment.save
			redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_comment.create_success')
		else
			redirect_to meal_path(params[:meal_id]), :notice => I18n.t('meal_comment.create_fail')
	end
=end

	def destroy

	end

	def edit
	end

	def update
		if @comment.update_attributes(params[:comment])
			redirect_to meal_path(@comment.meal_id), :notice => I18n.t('meal_comment.create_success')
		else
      		redirect_to edit_meal_path(@comment.meal_id),  :alert => I18n.t('meal_comment.create_fail')
    	end
	end

  private
  def get_meal_comment
    @comment = Comment.find(params[:id])
  end

  def check_user
    unless current_user.id == @comment.user_id
      redirect_to root_path, :notice => I18n.t('application.rights_fail')
    end
  end

end
