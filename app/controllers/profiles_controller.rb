class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    current_dog.profile = @profile
    if @profile.save!
      redirect_to doghouse_path
    else
      render "new"
    end
  end

  def edit
  end

end