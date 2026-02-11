module DashboardHelper
    def num_of_participants(event)
        event.enrollments.count
    end
end
