class MessagesController < ApplicationController
  
  before_filter :check_login, :only=> [:index, :new, :create]
  before_filter :check_receiver, :only=> [:new, :create]

  def index
    
  end

  def show
    @msg = Message.find(:first, :conditions => ["id = ?", params[:id]])
    if @msg.received_messageable_id == current_user.id
      @msg.update_attribute(:opened, true)
    else
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
    
  end

  def new
    @new_message = Message.new
  end

  def create
    current_user.send_message(@receiver, params[:topic], params[:body])
    redirect_to root_path
  end

  protected
  def check_login
    unless current_user
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

  def check_receiver
    unless @receiver = User.find(:first, :conditions => [ "id = ?", params[:receiver]])
      flash[:alert] = "No such User"
      redirect_to root_path
    end
  end
end
