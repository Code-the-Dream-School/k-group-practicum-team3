module EnrollmentsHelper
  def enrolled_in?(event, user)
    return false if event.blank? || user.blank?
    Enrollment.exists?(event_id: event.id, user_id: user.id)
  end

  def event_full?(event)
    return false if event.nil?
    return false if event.max_capacity.nil?

    event.enrollments.count >= event.max_capacity
  end

  def can_enroll?(event, user)
    return false if event_owner?(user, event)
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
    return false if event_owner?(user, event)

    enrolled_in?(event, user)
  end


  def enrollment_status_label(event, user)
    return "Login required" if user.blank?
    return "Organizer" if event_owner?(user, event)
    return "Enrolled" if enrolled_in?(event, user)
    return "Full" if event_full?(event)

    "Open"
  end


  def can_view_participants?(event, user)
    event_owner?(user, event)
  end

  def event_owner?(user, event)
  user.present? && event.present? && event.user_id == user.id
end
end
