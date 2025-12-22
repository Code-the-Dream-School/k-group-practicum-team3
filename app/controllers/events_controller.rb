class EventsController < ApplicationController
  def new
    #
  end

  def create
    redirect_to new_event_path, notice: "Event submitted"
  end
end
