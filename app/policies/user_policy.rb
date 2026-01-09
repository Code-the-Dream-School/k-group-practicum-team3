class UserPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def update?
    owner?
  end

  private

  def owner?
    user.present? && record.id == user.id
  end
end
