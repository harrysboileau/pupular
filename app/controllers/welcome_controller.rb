class WelcomeController < ApplicationController

  skip_before_filter :require_login

  def index
    if current_dog
      redirect_to doghouse_path
    end
  end
end
