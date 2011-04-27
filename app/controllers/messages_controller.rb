class MessagesController < ApplicationController
  
  before_filter :check_login, :only=> [:inbox, :new, :create]
  before_filter :check_receiver, :only=> [:new, :create]

  def index
    redirect_to :action => "inbox"
  end

  def inbox
    @messages = current_user.received
    render :index
  end

  def outbox
    @messages = current_user.sent
    render :index
  end

  def show
    @msg = Message.find(params[:id])
    if @msg.received_messageable_id == current_user.id
      @msg.update_attribute(:opened, true)
    else
      unless @msg.sent_messageable_id == current_user.id
        redirect_to root_path, :notice => "no rights for this action"
      end
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
