class MessagesController < ApplicationController
  def index
    @dog = current_dog
    @inbox = @dog.received_messages
  end

  def new
    @dog = current_dog
    
    @message_id = (params[:message_id]).to_i
    if @message_id > 0
      @message_to_reply = Message.find(@message_id)
      @dog_to_reply = Dog.find(@message_to_reply.sender_id)
      @dog_username_to_reply = @dog_to_reply.username
      render '_reply'
    else
      render '_new'
    end
  end

  def get_id
    dog = Dog.find_by_username_or_email(params["data"])
    if request.xhr?
      render json: {dog_id: dog.id }
    end
  end

  def create
    @receiver = Dog.find(params[:dog_id])
    @sender = current_dog
    @receiver.received_messages << @sender.sent_messages.create(type:params[:type],subject:params[:subject],content:params[:content])
    if request.xhr
      render 'messages/index'
    else
      redirect_to dog_messages_path
    end        
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to dog_messages_path
  end
end
