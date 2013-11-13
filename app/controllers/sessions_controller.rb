class SessionsController < ApplicationController

  skip_before_filter :require_login

  def new
    @dog_session = DogSession.new
  end

  def create
    @dog_session = DogSession.new(params[:dog_session])

    # if incomplete_user? redirect_to name; else

    if @dog_session.save
      if current_dog.is_registered?
        redirect_to doghouse_path
      else
        redirect_to name_path
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
