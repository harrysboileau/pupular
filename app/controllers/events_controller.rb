class EventsController < ApplicationController

  def show
  end

  def new
    @event = Event.new
  end
end
