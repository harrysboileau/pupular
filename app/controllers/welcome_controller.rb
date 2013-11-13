class WelcomeController < ApplicationController

  skip_before_filter :require_login

  def index
    redirect_to doghouse_path if current_dog
  end
end
