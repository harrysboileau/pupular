class ProfilesController < ApplicationController

  def new
    if params[:format]
      @is_new = true
    end
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.not_empty?
      if current_dog.profile = @profile
      else
        render "new"
      end
    end

    if params[:is_new]
      redirect_to doghouse_path
    else
      redirect_to dog_path(current_dog)
    end
  end

  def update
    @profile = Profile.find(params[:id])

    params["value"].each do |key, value|
      @profile.send((key+"=").to_sym, value)
      @profile.save
    end

    if request.xhr?
      render :json => params["value"].to_json
    else
      redirect_to dog_path(current_dog)
    end

  end

end
