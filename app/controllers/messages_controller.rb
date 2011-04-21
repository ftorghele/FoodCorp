class MessagesController < ApplicationController
  
  before_filter :check_login, :only=> [:index, :new, :create]
  before_filter :check_receiver, :only=> [:new, :create]

  def index
    
  end

  def new
    @new_message = Message.new
  end

  def create
    
    current_user.send_message(receiver, "Message to user2", "Hi user 2!;-)")
  end

  protected
  def check_login
    unless current_user
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

  def check_receiver
    unless receiver = User.find(:first, :conditions => [ "id = ?", params[:id]])
      flash[:alert] = "No such User"
      redirect_to root_path
    end
  end
end
