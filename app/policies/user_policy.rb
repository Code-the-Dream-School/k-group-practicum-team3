class UserPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin)
  end

  def show?
    record.id == user.id || user.has_role?(:admin)
  end

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
