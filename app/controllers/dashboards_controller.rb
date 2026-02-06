class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.has_role?(:organizer)
      load_organizer_dashboard
    else
      load_participant_dashboard
    end
  end

  private

  def load_organizer_dashboard
    @events = current_user.organized_events
    .order(starts_at: :desc)
    .includes(:enrollments)

    @organized_events = @events
    @enrolled_events  = current_user.enrolled_events.order(starts_at: :asc)
  end

  def load_participant_dashboard
    @events = [] # 👈 critical: prevents nil.each
    @organized_events = []

    @enrolled_events = current_user.enrolled_events
    .order(starts_at: :asc)

    @recommended_events = Event
    .where.not(id: @enrolled_events.select(:id))
    .order(starts_at: :asc)
    .limit(5)
  end
end
