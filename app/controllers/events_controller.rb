class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    p params
    @dog = Dog.find(params[:dog_id])
    @event = @dog.events.new(params[:event])
    @event.save!
    redirect_to doghouse_path
  end

end
