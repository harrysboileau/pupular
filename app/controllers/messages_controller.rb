class MessagesController < ApplicationController
  def index
    @dog = Dog.find(1)
    @inbox = @dog.received_messages
  end

  def new
    
  end

  def create
    @receiver_name = params[:message][:dog_id]
    p @receiver_name  
    @receiver = Dog.find_by_username(@receiver_name)
    p @receiver
    @sender = Dog.find(1)

    @receiver.received_messages << @sender.sent_messages.create(type:"Personal",subject:params[:message][:subject],content:params[:message][:content])
    redirect_to doghouse_path(1)
  end



end
