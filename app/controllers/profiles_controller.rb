class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create

    @profile = Profile.new(params[:profile])
    if @profile.not_empty?
      begin
        current_dog.profile = @profile
      rescue
        render "new"
      else
        redirect_to doghouse_path
      end
    end
    redirect_to doghouse_path
  end

  def edit
  end

end