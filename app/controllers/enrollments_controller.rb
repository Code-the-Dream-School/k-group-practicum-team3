class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @enrollment = @event.enrollments.build(user: current_user)

    if @enrollment.save
      puts "Enrolled successfully."
    else
      puts "Error Enrolling"
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
