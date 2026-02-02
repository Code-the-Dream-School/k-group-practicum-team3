class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    if @event.enrollments.exists?(user_id: current_user.id)
    redirect_to @event, alert: "You have already joined this event."
    return
    end

    @enrollment = @event.enrollments.build(user: current_user)
    authorize @enrollment

    if @enrollment.save
      redirect_to @event, notice: "You have joined the event."
    else
      redirect_to @event, alert: "Unable to join the event."
    end
  end

def destroy
    @enrollment = @event.enrollments.find_by(user: current_user)

    if @enrollment&.destroy
      puts "Left event successfully."
    else
      puts "Error leaving event."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
