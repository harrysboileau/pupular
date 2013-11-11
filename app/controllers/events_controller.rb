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
    @event.save!
    @dog.attended_events << @event
    redirect_to doghouse_path
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
