class WelcomeController < ApplicationController
  def index
    if current_dog
      redirect_to doghouse_path
    end
  end
end
