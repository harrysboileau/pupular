class DogsController < ApplicationController

  skip_before_filter :require_login, only: [:new, :savehuman, :name, :create]

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
      redirect_to new_dog_path
    end
  end

  def create
    @dog = current_dog

    if @dog.update_attributes(params[:dog])
      redirect_to new_profile_path("new")
    else
      render "name"
    end
  end

  def doghouse
    @dog = current_dog
    @events = @dog.attended_events #.where("start_time > ? and date > ?", DateTime.now.utc.strftime("%T"), DateTime.now.utc.strftime("%F"))
    @invited_to_events = @dog.invited_to_events # why is it even neecssary to reassign this? just use @dog.invited_to_guests in the view
  end

  def show
    @dog = Dog.find(params[:id])
    if @dog.profile || @dog != current_dog # should this be an AND or an OR ?
      @profile = @dog.profile
    else
      redirect_to new_profile_path
    end
  end

  def search
    @dogs = Dog.all
  end

  def filter_search
    @sent_requests = current_dog.sent_requests
    @friends = current_dog_pals_usernames
    @search_term = params[:search_term]
    @dogs = Dog.search(@search_term)
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
    Dog.find(params[:pending_pal_id]).pending_pals << current_dog
    redirect_to search_path
  end

  def load_friends
    render json: { friends: current_dog.pals.map { |pal| pal.name } }
  end

  def verify_friend
    pal_to_check = Dog.find_by_name(params[:friend_name])
    event = Event.find(params[:event_id])
    if event.invited_pals.include?(pal_to_check)
      render json: { verification: "already_invited"}
    elsif current_dog_pals_names.include?(params[:friend_name])
      render json: { verification: "friend"}
    elsif current_dog == pal_to_check
      render json: { verification: "self"}
    else
      render json: { verification: "not_friend"}
    end
  end

  def add_friends_to_event
    # add error handling and also get yelled at by abi for having comments in master branch code #+!
    params[:friends_to_add].each do |pal_name|
      invitation = Invitation.new
      invitation.dog = current_dog
      invitation.invited_pal = Dog.find_by_name(pal_name)
      invitation.event_id = params[:event_id]
      invitation.save
    end
    render nothing: true
  end

  def accept_invitation
    event = Event.find(params[:event_id])
    event.attendees << current_dog
    invitation = Invitation.find_by_event_id_and_invited_pal_id(params[:event_id], current_dog.id)
    invitation.destroy
    redirect_to doghouse_path
  end

  def decline_invitation
    invitation = Invitation.find_by_event_id_and_invited_pal_id(params[:event_id], current_dog.id)
    invitation.declined = true
    invitation.save
    redirect_to doghouse_path
  end

  def qr
  end

  # Below code preserved to detail in-app QR decoding process.

  # def camera
  #   @qr = Qr.new
  # end

  # def decode

  #   @qr = Qr.create(params[:qr])

  #   path = 'public/uploads/qr/image/profile_something.jpg'

  #   decoded_image = ZBar::Image.from_jpeg(File.read(path)).process

  #   redirect_to decoded_image[0].data
  # end

end
