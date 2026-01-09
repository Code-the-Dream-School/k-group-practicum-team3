module UserHelper
  def organizer?(user)
    user.has_role?(:organizer)
  end

  def student?(user)
    user.has_role?(:student)
  end

  def parent?(user)
    user.has_role?(:parent)
  end

  def admin?(user)
    user.has_role?(:admin)
  end

  def display_role(user)
    if admin?(user)
      "Admin"
    elsif organizer?(user)
      "Organizer"
    elsif parent?(user)
      "Parent"
    elsif student?(user)
      "Student"
    else
      ""
    end
  end

  def can_manage_event?(event, user)
    event.user_id == user.id
  end

  def can_create_events?(user)
    organizer?(user)
  end

  def dashboard_path_for(_user)
    # TODO: dashboards not implemented yet
    "#"
  end

  def navigation_links_for(_user)
    # TODO: navigation not implemented yet
    []
  end

  def user_display_name(user)
    full_name = [ user.first_name, user.last_name ].compact.join(" ")

    if full_name.present?
      full_name
    elsif user.email.present?
      user.email
    else
      ""
    end
  end
end
