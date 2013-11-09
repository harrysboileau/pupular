class SessionsController < ApplicationController
  def new
    @dog_session = DogSession.new
  end

  def create
    @dog_session = DogSession.new(params[:dog_session])

    # if incomplete_user? redirect_to name; else

    if @dog_session.save
      if current_dog.is_registered?
        redirect_to "/doghouse"
      else
        redirect_to '/name'
      end
    else
      render "new"
    end
  end

  def destroy
    @dog_session = DogSession.find
    @dog_session.destroy

    redirect_to :root
  end
end
