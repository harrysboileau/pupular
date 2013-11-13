class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  helper_method :current_dog
  before_filter :require_login

  private

  def current_dog_session
    @current_dog_session ||= DogSession.find
  end

  def current_dog
    @current_dog ||= current_dog_session && current_dog_session.record
  end

  def current_dog_pals_names
    current_dog.pals.map { |pal| pal.name }
  end

  def current_dog_pals_usernames
    current_dog.pals.map { |pal| pal.username }
  end

  def require_login
    if !current_dog
      redirect_to root_url
    end
  end
end
