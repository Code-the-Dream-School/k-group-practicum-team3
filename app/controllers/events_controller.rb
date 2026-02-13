class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :search ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event
      .includes(:user, media_files_attachments: :blob)
      .with_open_registration
      .order(starts_at: :asc)

    @events = @events.filter_by_category(params[:category]) if params[:category].present?
    @events = @events.filter_by_location(params[:location]) if params[:location].present?
    @events = @events.filter_by_state(params[:state]) if params[:state].present?
    @events = @events.filter_by_city(params[:city]) if params[:city].present?
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
      @can_view_participants = current_user.id == @event.user_id || @already_enrolled
    else
      @already_enrolled = false
      @can_view_participants = false
    end

    @event_full = @event.max_capacity.present? && @event.enrollments.count >= @event.max_capacity

    if @event.max_capacity.present?
      @event_full = @event.enrollments.count >= @event.max_capacity
    else
      @event_full = false
    end
  end

  def edit
    @event = Event.find(params[:id])
      if @event.starts_at.past?
      flash[:alert] = "Past events cannot be edited."
      redirect_to dashboard_path
      return
      end
    authorize @event
  end

  def update
    authorize @event

    filtered_params = event_params.dup

    if filtered_params[:media_files].present?
      filtered_params[:media_files].reject!(&:blank?)
    end

    filtered_params.delete(:media_files) if filtered_params[:media_files].blank?

    if @event.update(filtered_params)
      if params[:from] == "dashboard"
        redirect_to dashboard_path, notice: "Event updated successfully"
      else
        redirect_to @event, notice: "Event updated successfully"
      end
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

  def search
    if params[:search].present?
      @events = Event.where("title LIKE :search OR description LIKE :search", search: "%#{params[:search]}%")
    else
      @events = []
    end

    render :index
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
