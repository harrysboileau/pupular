class WelcomeController < ApplicationController

  skip_before_filter :require_login

  def index
    # make this one line
    if current_dog
      redirect_to doghouse_path
    end
  end
end
