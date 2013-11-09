class MessagesController < ApplicationController
  def index
    @dog = current_dog
    @inbox = @dog.received_messages
  end

  def new
    
  end

  def create
    @receiver_name = params[:message][:dog_id]
    p @receiver_name  
    @receiver = Dog.find_by_username(@receiver_name)
    p @receiver
    @sender = current_dog

    @receiver.received_messages << @sender.sent_messages.create(type:"Personal",subject:params[:message][:subject],content:params[:message][:content])
    redirect_to doghouse_path(current_dog)
  end



end
