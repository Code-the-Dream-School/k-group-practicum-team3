class EventPolicy < ApplicationPolicy
  def new?
    organizer?
  end

  def create?
    organizer?
  end

  def edit?
    organizer? && owns_record? && not_past?
  end

  def update?
    organizer? && owns_record? && not_past?
  end

  def destroy?
    organizer? && owns_record? && not_past?
  end

  def destroy?
    organizer? && owns_record?
  end

  private

  def organizer?
    user.present? && user.has_role?(:organizer)
  end

  def owns_record?
    record.user_id == user.id
  end

  def not_past?
    !record.past?
  end
end
