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
    @profile.send((params["value"].first[0]+"=").to_sym, params["value"].first[1])
    @profile.save
    if request.xhr?
      render :json => { value: params["value"].first[1] }
    else
      redirect_to dog_path(current_dog)
    end
  end

end
