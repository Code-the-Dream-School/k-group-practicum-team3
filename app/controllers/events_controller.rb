class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @events = Event.includes(:user).order(starts_at: :asc)
  end
  def show
    @event = Event.find(params[:id])

      if user_signed_in?
       @already_enrolled = @event.enrollments.exists?(user_id: current_user.id)
      else
      @already_enrolled = false
    end

      if @event.max_capacity.present?
        @event_full = @event.enrollments.count >= @event.max_capacity
     else
      @event_full = false
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully"
    else
      render :edit
    end
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = current_user.organized_events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: "Event submitted"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event

    @event.destroy
    redirect_to root_path
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
