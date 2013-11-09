class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_dog

  private

  def current_dog_session
    return @current_dog_session if defined?(@current_dog_session)
    @current_dog_session = DogSession.find
  end

  def current_dog
    return @current_dog if defined?(@current_dog)
    @current_dog = current_dog_session && current_dog_session.record
  end
end
