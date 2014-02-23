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
      # the below line is repeated 5 times in the code so far -- we should think
      # about a way to extract or automate it (low priority)
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
    # remove commented code
    @events = @dog.attended_events #.where("start_time > ? and date > ?", DateTime.now.utc.strftime("%T"), DateTime.now.utc.strftime("%F"))
    @invited_to_events = @dog.invited_to_events
  end

  def show
    @dog = Dog.find(params[:id])
    if @dog.profile || @dog != current_dog
      @profile = @dog.profile
    else
      redirect_to new_profile_path
    end

  end

  # this controller has way too much responsibility
  # need to put search, friend, and invitation logic into
  # their own controllers

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

    # extract to method for readability
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

    # get yelled at by myself for having comments in master branch code and look
    # into what error handling we need and extract the logic inside the block
    # to its own method for readability

    # add error handling and also get yelled at by abi for having comments in master branch code
    params[:friends_to_add].each do |pal_name|
      invitation = Invitation.new
      invitation.dog_id = current_dog.id
      invitation.invited_pal_id = Dog.find_by_name(pal_name).id
      invitation.event_id = params[:event_id]
      invitation.save
    end
    render nothing: true
  end

  def accept_invitation

    #moar moar methods
    event = Event.find(params[:event_id])
    # e.g. event.add_attendee(dag)
    event.attendees << current_dog
    # e.g. invitation = found_invitation (and extract logic to private method)
    invitation = Invitation.find_by_event_id_and_invited_pal_id(params[:event_id], current_dog.id)
    invitation.destroy
    redirect_to doghouse_path
  end

  def decline_invitation
    # extract first line (as requested above) and use update attributes to replace other two lines
    invitation = Invitation.find_by_event_id_and_invited_pal_id(params[:event_id], current_dog.id)
    invitation.declined = true
    invitation.save
    redirect_to doghouse_path
  end

  def qr
  end

  # we should delete this at some point

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
