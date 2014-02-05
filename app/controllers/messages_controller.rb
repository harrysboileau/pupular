class MessagesController < ApplicationController
  # make your code style consistent, there are newlines below class delcarations in other files
  def index
    @dog = current_dog
    @inbox = @dog.received_messages

    @sent_messages = @dog.sent_messages
    p @sent_messages # remove this
  end

  def new
    @dog = current_dog

    @message_id = (params[:message_id]).to_i
    if @message_id > 0
      @message_to_reply = Message.find(@message_id)
      @subject_reply = "re: " + @message_to_reply.subject # yikes, can we move this logic somewhere singular, deliberate, and precious? dont just "splip" a little "re:" in there
      @dog_to_reply = Dog.find(@message_to_reply.sender_id)
      @dog_username_to_reply = @dog_to_reply.name
      # render partial: 'reply'
    # else
      # render partial: 'new'
    end
  end

  def get_id
    dog = Dog.find_by_name(params["data"])
    if request.xhr?
      render json: {dog_id: dog.id, current_dog_id: current_dog.id }
    end
  end

  def create
    @receiver = Dog.find(params[:dog_id])
    @sender = current_dog # WHY ARE YOU REASSIGNING THIS
    @receiver.received_messages << current_dog.sent_messages.create(type:params[:type],
                                                                subject:params[:subject],
                                                                content:params[:content])
    if request.xhr?
      render :nothing => true
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
