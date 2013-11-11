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
    @event.send (params["value"].first[0]+"=").to_sym, params["value"].first[1]
    @event.save
    if request.xhr?
      render :json => { value: params["value"].first[1] }
    else
      redirect_to dog_event_path(params[:dog_id], params[:id])
    end
  end

end
