class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        @events = current_user.events
    end

    def show
        @event = Event.find(params[:id])
        authorize @event
    end
end
