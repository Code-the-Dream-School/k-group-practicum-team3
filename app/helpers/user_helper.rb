module UserHelper
    def organizer?(user)
        if user.has_role? :organizer
            return true
        else
            return false
        end
    end

  # Returns true if the user has the student role.
  def student?(user)
    if user.has_role? :student
      return true
    else
      false
    end
  end

  # Returns true if the user has the parent role.
  def parent?(user)
    if user.has_role? :parent
      return true
    else
      false
    end
  end

  # Returns true if the user has the admin role.
  def admin?(user)
    if user.has_role? :admin
      return true
    else
      return false
    end
  end

  # Returns a human-friendly version of the user’s role (e.g. “Organizer”).
  def display_role(user)
    if admin?(user)
      return "Admin"
    elsif organizer?(user)
      return "Organizer"
    elsif parent?(user)
      return "Parent"
    elsif student?(user)
      return "Student"
    else
      return ""
    end
  end

  # Returns true if the user can create, edit, or delete the given event.
  def can_manage_event?(event, user)
    if event.user_id == user.id 
      return true       
    end
    return false

  end

  # Returns true if the user is allowed to create new events.
  def can_create_events?(user)
    if user.has_role? :organizer
      return true
    end
    return false
  end

  # Returns the correct dashboard path based on the user’s role.
  def dashboard_path_for(user)
    # TODO: No dashboard yet
    return "TODO: dashboard_path(user)"
  end

  # Returns a list of navigation links appropriate to the user’s role.
  def navigation_links_for(user)
    #TODO: No navigation pages yet
    if admin?(user)
        return "TODO: navigation_links_for(user)"
    elsif organizer?(user)
        return "TODO: navigation_links_for(user)"
    elsif parent?(user)
        return "TODO: navigation_links_for(user)"
    elsif student?(user)
        return "TODO: navigation_links_for(user)"
    else
        return "TODO: navigation_links_for(user)"
    end
  end

  # Returns the best name to show for a user (name or email fallback).
  def user_display_name(user)
    if user.name.present?
      return user.name
    elsif user.email.present?
      return user.email
    else
      return ""
    end
  end

end
