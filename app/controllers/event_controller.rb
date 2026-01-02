class EventController < ApplicationController
  #TODO: Test these functions in view
  def index
    @events = Event.all
  end

  def show
  end

  def edit
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully saved." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update event
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete event
  def destroy
    @event.destroy

    respond_to do |format|
      format.html {redirect_to events_path, status: :see_other, notice: "Event successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Private methods
  private

  def set_event
    @event = Event.find_by(params(:id))
  end

  def event_params
    params.expects( event: [ :title, :starts_at, :category, :allowed_gender, :rsvp, :min_age, :max_age, :max_capacity ] )
  end
end
