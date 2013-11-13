class ProfilesController < ApplicationController

  def new
    @is_new = true if params[:format] # instead of this unnecessary instance var, in the view you could do @profile.new_record?

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

    if params[:is_new] # find a way to refactor this
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
