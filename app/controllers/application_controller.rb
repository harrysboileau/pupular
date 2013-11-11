require 'application_helper' # this line shouldnt be necessary...
class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  helper_method :current_dog

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
end
