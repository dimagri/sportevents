class MessagesController < ApplicationController

  def inbox
  	@messages = current_user.recieved_messages 
  end

  def sentbox
  	@messages = current_user.sent_messages
  end

  def show
  	@message = Message.find(params[:id])
    @message.mark_as_read_by(current_user)
  end

  def new
    @recipient = User.find(params[:recipient_id])
  	@message = current_user.sent_messages.build
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      flash[:notice] = "Ваше сообщение отправлено"
      redirect_to :back
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :recipient_id)
  end

end
