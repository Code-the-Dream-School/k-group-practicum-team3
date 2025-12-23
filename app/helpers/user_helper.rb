module UserHelper
    def organizer?(user)
        if user.has_role? :organizer
            true
        else
            false
        end
    end

  # Returns true if the user has the student role.
  def student?(user)
    if user.has_role? :student
      true
    else
      false
    end
  end

  # Returns true if the user has the parent role.
  def parent?(user)
    if user.has_role? :parent
      true
    else
      false
    end
  end

  # Returns true if the user has the admin role.
  def admin?(user)
    if user.has_role? :admin
      true
    else
      false
    end
  end

  # Returns a human-friendly version of the user’s role (e.g. “Organizer”).
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

  # Returns true if the user can create, edit, or delete the given event.
  def can_manage_event?(event, user)
    if event.user_id == user.id
      true
    end
    false
  end

  # Returns true if the user is allowed to create new events.
  def can_create_events?(user)
    if user.has_role? :organizer
      true
    end
    false
  end

  # Returns the correct dashboard path based on the user’s role.
  def dashboard_path_for(user)
    # TODO: No dashboard yet
    "TODO: dashboard_path(user)"
  end

  # Returns a list of navigation links appropriate to the user’s role.
  def navigation_links_for(user)
    # TODO: No navigation pages yet
    if admin?(user)
        "TODO: navigation_links_for(user)"
    elsif organizer?(user)
        "TODO: navigation_links_for(user)"
    elsif parent?(user)
        "TODO: navigation_links_for(user)"
    elsif student?(user)
        "TODO: navigation_links_for(user)"
    else
        "TODO: navigation_links_for(user)"
    end
  end

  # Returns the best name to show for a user (name or email fallback).
  def user_display_name(user)
    if user.name.present?
      user.name
    elsif user.email.present?
      user.email
    else
      ""
    end
  end
end
