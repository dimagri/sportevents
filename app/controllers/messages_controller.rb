class MessagesController < ApplicationController


  def inbox
  	@messages = current_user.recieved_messages 
  end

  def sentbox
  	@messages = current_user.sent_messages
  end

  def show
  	@message = current_user.messages.find(params[:id])
  end

  def new
  	@message = @user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:notice] = "Ваше сообщение отправлено"
      redirect_to :back
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :author_id, :recipient_id)
  end

end
