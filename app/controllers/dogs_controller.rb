class DogsController < ApplicationController

  def new
    @dog = Dog.new
  end

  def savehuman
    @dog = Dog.new(params[:dog])
    if @dog.save && DogSession.create(params[:dog])
      redirect_to name_path
    else
      render "new"
    end
  end

  def name
    if current_dog
      @dog = current_dog
    else
      @dog = Dog.new(email: "Something went wrong")
    end
  end

  def create
    @dog = current_dog

    if @dog.update_attributes(params[:dog])
      redirect_to new_profile_path
    else
      render "name"
    end
  end

  def doghouse
    @dog = current_dog
    @events = @dog.events
  end

  def show
    @dog = Dog.find(params[:id])
    if @dog.profile || @dog != current_dog
      @profile = @dog.profile
    else
      redirect_to new_profile_path
    end

  end

  def search
    @dogs = Dog.all
  end

  def filter_search
    @sent_requests = current_dog.outstanding_requests.map{ |req| Dog.find(req.dog_id).username }
    @friends = current_dog.pals.map{ |pal| pal.username }
    @search_term = params[:search_term]
    @dogs = Dog.where('name LIKE ?', "%#{@search_term}%").all
    render layout: false
  end

  def add_friend
    current_dog.accept_pal(params[:pending_pal_id])
    redirect_to doghouse_path(current_dog)
  end

  def reject_friend
    current_dog.deny_pal(params[:pending_pal_id])
    redirect_to doghouse_path(current_dog)
  end

  def friend_request
    begin
      Dog.find(params[:pending_pal_id]).pending_pals << current_dog
    rescue
    end
    redirect_to search_path
  end

  def load_friends
    render json: { friends: current_dog.pals.map { |pal| pal.name } }
  end

  def verify_friend
    pal_to_check = Dog.find_by_name(params[:friend_name])
    event = Event.find(params[:event_id])
    if event.attendees.include?(pal_to_check)
      render json: { verification: "already_attending"}
    elsif current_dog_pals_names.include?(params[:friend_name])
      render json: { verification: "friend"}
    else
      render json: { verification: "not_friend"}
    end
  end

  def add_friends_to_event
    event = Event.find(params[:event_id])
    params[:friends_to_add].each do |pal_name|
      event.attendees << Dog.find_by_name(pal_name)
    end
    render nothing: true
  end

end
