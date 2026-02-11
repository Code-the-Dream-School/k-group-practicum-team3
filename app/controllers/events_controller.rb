class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @events = Event.includes(:user).order(starts_at: :asc)

    if params[:location].present?
      @events = @events.filter_by_location(params[:location])
    end

    if params[:state].present?
      @events = @events.filter_by_state(params[:state]) if params[:state].present?
    end

    if params[:city].present?
      @events = @events.filter_by_city(params[:city]) if params[:city].present?
    end
    @events = @events.filter_by_category(params[:category]) if params[:category].present?
  end

  def show
    @event = Event.find(params[:id])
    @participants = @event.participants

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
    if @event.starts_at.past?
    flash[:alert] = "Past events cannot be edited."
    redirect_to dashboard_path
    return
    end
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    if @event.update(event_params)
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
      redirect_to @event, notice: "Event submitted"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event

    @event.destroy
    redirect_to dashboard_path, notice: "Event deleted"
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
