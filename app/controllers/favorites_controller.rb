class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ create, :destroy ]

  def index
    @events = current_user.favorited_events
  end

  def create
    current_user.favorites.create!(event: @event)
    redirect_back fallback_location: events_path
  end

  def destroy
    current_user.favorites.find_by(event: @event)&.destroy
    redirect_back fallback_location: events_path
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
