class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        #@events = current_user.events
        @events = Event.where(id: current_user.id)
    end
end
