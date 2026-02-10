class EnrollmentPolicy < ApplicationPolicy
  def create?
    return false if user.nil?
    return false if event_owner?
    return false if already_enrolled?
    return false if event_full?

    true
  end

  private

  def event
    record.event
  end

  def event_owner?
    event.user_id == user.id
  end

  def already_enrolled?
    event.enrollments.exists?(user_id: user.id)
  end

  def event_full?
    return false if event.nil?
    return false if event.max_capacity.nil?

    event.enrollments.count >= event.max_capacity
  end
end
