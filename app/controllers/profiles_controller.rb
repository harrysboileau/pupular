class ProfilesController < ApplicationController

  def new
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
    # if @profile.not_empty?
    #   begin
    #     current_dog.profile = @profile
    #   rescue
    #     render "new"
    #   else
    #     redirect_to doghouse_path
    #   end
    # else

    # redirect_to doghouse_path
    # end
    redirect_to doghouse_path
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
