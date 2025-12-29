class DashboardController < ApplicationController
    before_action :set_user
    
    def index
        @events = Event.where(@user)
    end

    private
        #set the user of this dashboard that also has the role of organizer
        def set_user
            @user = User.find_by(user_params).with_role :organizer
        end
        
        # Only allow a list of trusted parameters through.
        def user_params
            #params.expect(user: [ ])
        end
end
