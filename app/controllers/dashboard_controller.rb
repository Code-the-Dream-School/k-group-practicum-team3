class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        @events = Event.where(params(current_user.id))
    end
end
