module EnrollmentsHelper
  def enrolled_in?(event, user)
    return false if event.blank? || user.blank?
    Enrollment.exists?(event_id: event.id, user_id: user.id)
  end

  def event_full?(event)
    return false unless event.respond_to?(:max_capacity)

    capacity = event.max_capacity
    return false if capacity.blank?

    Enrollment.where(event_id: event.id).count >= capacity
  end

  def can_enroll?(event, user)
    return false if organizer?(event, user)
    return false if enrolled_in?(event, user)
    return false if event_full?(event)

    true
  end


  def enrollment_count(event)
    return "0 participants" if event.blank?

    count = Enrollment.where(event_id: event.id).count

    if event.respond_to?(:max_capacity) && event.max_capacity.present?
      "#{count} / #{event.max_capacity} participants"
    else
      "#{count} participant#{count == 1 ? '' : 's'}"
    end
  end


  def show_enroll_button?(event, user)
    can_enroll?(event, user)
  end


  def show_leave_button?(event, user)
    return false if organizer?(event, user)

    enrolled_in?(event, user)
  end


  def enrollment_status_label(event, user)
    return "Login required" if user.blank?
    return "Organizer" if organizer?(event, user)
    return "Enrolled" if enrolled_in?(event, user)
    return "Full" if event_full?(event)

    "Open"
  end


  def can_view_participants?(event, user)
    organizer?(event, user)
  end

  private

  def organizer?(event, user)
    event.respond_to?(:user_id) && event.user_id == user.id
  end
end
