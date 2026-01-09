class DashboardController < ApplicationController
    #before_action :authenticate_user!
    # Displays only the events associated with the current user
    def index
        # TODO: Uncomment when user can be signed in
        #@events = Event.where(params(current_user.id))
        @events = Event.where(user_id: 1)
    end
end
