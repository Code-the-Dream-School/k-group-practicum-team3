class EventsController < ApplicationController
  def index
    @events = Event.includes(:user).order(starts_at: :asc)
  end
  def show
    @event = Event.find(params[:id])
  end  
  def new
    @event = Event.new
  end

  def create
    @event = Event.new

    redirect_to new_event_path, notice: "Event submitted"
  end
end