class EventsController < ApplicationController
  def index
    @events = Event.includes(:organizer).order(starts_at: :asc)
  end
end