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
    begin
      @event.save!
    rescue
      render json: {error: "Could not create event."}
    else
      @dog.attended_events << @event
      render "_add_friend_table"
    end
  end

  def update
    params[:event].parse_time_select! :start_time
    params[:event][:date] = format_date(params[:event][:date])
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
