class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @enrollment = @event.enrollments.build(user: current_user)

    if @enrollment.save
      redirect_to @event, notice: "You have joined the event."
    else
      redirect_to @event, alert: "Unable to join the event."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
