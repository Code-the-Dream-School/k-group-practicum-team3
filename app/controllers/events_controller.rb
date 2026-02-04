class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event
      .includes(:user, media_files_attachments: :blob)
      .with_open_registration
      .order(starts_at: :asc)
  end

  def show
    @participants = @event.participants
    @already_enrolled = user_signed_in? && @event.enrollments.exists?(user_id: current_user.id)
    @event_full = @event.max_capacity.present? && @participants.count >= @event.max_capacity

    @can_view_participants =
      user_signed_in? &&
      (current_user.id == @event.user_id ||
      @event.enrollments.exists?(user_id: current_user.id))

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
    authorize @event
  end

  def update
    # authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully"
    else
      render :edit, status: :unprocessable_entity
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
      redirect_to @event, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_path, notice: "Event deleted successfully"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :location, :city, :state,
      :starts_at, :ends_at, :registration_deadline, :category, :price, :min_age, :max_age,
      :allowed_gender, :rsvp, :accessible, :max_capacity,
      media_files: []
    )
  end
end
