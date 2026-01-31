class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :search ]

  def index
    @events = Event.includes(:user).order(starts_at: :asc)
  end
  def show
    @event = Event.find(params[:id])
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

  def search
      if params[:search].present?
        @results = Event.all.where("title LIKE :search OR description LIKE :search", search: "%#{params[:search]}%")
      else
        @results = Event.none
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
