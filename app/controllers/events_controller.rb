class EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: "Event submitted"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :description, :location, :city, :state,
      :starts_at, :ends_at, :category, :price, :min_age, :max_age,
      :allowed_gender, :rsvp, :accessible, :max_capacity
    )
  end
end
