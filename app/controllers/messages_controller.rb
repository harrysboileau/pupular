class MessagesController < ApplicationController
  def index
    @dog = Dog.find(1)
    @inbox = @dog.received_messages
  end

  def new
    
  end

  def create

    p params
    # dog2.received_messages << dog.sent_messages.create(type:"Automated",subject:"get with it",content:"get at it")
    # redirect_to doghouse_path(1)
  end



end
