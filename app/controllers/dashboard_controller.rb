class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        if organizer?(current_user)
            @events = Event.where(id: current_user.id)
        else
            redirect_to root_path, notice: "You do not have permission to view that page."
        end
    end
end
