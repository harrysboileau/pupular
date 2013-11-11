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
      render '_reply' # render :partial => "reply"
    else
      render '_new' # render :partial => "new"
    end
  end



  def create
    @receiver_name = params[:message][:dog_id]
    @receiver_name # WHAT IS THIS?
    @receiver = Dog.find_by_username(@receiver_name)
    @receiver # WHAT IS THIS?
    @sender = current_dog

    @receiver.received_messages << @sender.sent_messages.create(type:"Personal",
                                                                subject: params[:message][:subject],
                                                                content:params[:message][:content])
    redirect_to doghouse_path(current_dog)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to dog_messages_path
  end
end
