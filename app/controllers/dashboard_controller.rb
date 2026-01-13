class DashboardController < ApplicationController
    before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        # TODO: Needs joins table for registrations to display more than one event
        # @events = current_user.events
        @events = Event.where(user_id: current_user.id)
    end
end
