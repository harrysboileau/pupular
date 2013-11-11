class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id].to_i)
  end

  def new
    @event = Event.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @event = @dog.events.new(params[:event])
    begin
      # wrap this in an activerecord transaction
      @event.save!
      @dog.attended_events << @event
    rescue # it'd be ideal to specify the type of exception you want to catch
      render json: {error: "Could not create event."}
    else
      render "_add_friend_table" # render :partial => "add_friend_table"
    end
  end

  def update
    @event = Event.find(params[:id])
    params["value"].each do |key, value|
      @event.send((key+"=").to_sym, value)
      @event.save
    end
    if request.xhr?
      render :json => params["value"].to_json
    else
      redirect_to dog_event_path(params[:dog_id], params[:id])
    end
  end

end
