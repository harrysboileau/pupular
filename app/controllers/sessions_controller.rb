class SessionsController < ApplicationController
  def new
  end

  def create
    # Authenticate
    # if incomplete_user? redirect_to name; else
    redirect_to "/doghouse"
  end

  def signout

  end
end
