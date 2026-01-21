class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def index
    @enrollments = @event.enrollments.all
    authorize @enrollment
  end

  def new
    @enrollment = Enrollment.new
    authorize @enrollment
  end

  def create
    @enrollment = @event.enrollments.build(user_id:current_user.id)
    authorize @enrollment

    if @enrollment.save
      redirect_to @event, notice: "Enrollment succesfully submitted!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @enrollment
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def enrollment_params

  end
end