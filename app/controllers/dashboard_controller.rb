class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        @events = current_user.events
        #placeholder id for lack of a sign up functionality
        #@events = Event.where(user_id:2)
    end
end
