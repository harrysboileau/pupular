class EventsController < ApplicationController

  include EventHelper

  def show
    @event = Event.find(params[:id].to_i)
  end

  def new
    @event = Event.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    params[:event].parse_time_select! :start_time
    params[:event][:date] = format_date(params[:event][:date])
    @event = @dog.events.new(params[:event])

    # move this to the model:
    begin
      @event.transaction do
        @event.save!
        @dog.attended_events << @event
      end
    rescue
      render json: {error: "Could not create event."}
    else
      render :partial => "add_friend_table"
    end
  end

  def update
    @event = Event.find(params[:id])
    # move this to the model:
    params["value"].each do |key, value|
      @event.send((key+"=").to_sym, value)
      @event.save
    end
    params["value"]["start_time"] = @event.time
    if request.xhr?
      render :json => params["value"].to_json
    else
      redirect_to dog_event_path(params[:dog_id], params[:id])
    end
  end

end
