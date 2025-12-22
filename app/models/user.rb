class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  #Returns true if there is a currently authenticated user.
  #Note: I think this method isn't needed since devise already creates a helper method
  def logged_in?
    if user_signed_in?
      return true
  end

  def organizer?(user)
    if user.has_role? :organizer
      return true
    else 
      false
  end

  #Returns true if the user has the student role.
  def student?(user)
    if user.has_role? :student
      return true
    else 
      false
  end

  #Returns true if the user has the parent role.
  def parent?(user)
    if user.has_role? :parent
      return true
    else 
      false
  end

  def admin?(user)
    if user.has_role? :admin
      return true
    else 
      false
  end

  #Returns a human-friendly version of the user’s role (e.g. “Organizer”).
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

  #Returns the user full name
  def name
    return "#{User.first_name} #{User.last_name}"
  end

  #Returns the users full name given a user
  def name(user)
    return "#{user.first_name} #{user.last_name}"
  end

  #Returns true if the user can create, edit, or delete the given event.
  def can_manage_event?(event, user)
    #TODO
  end

  #Returns true if the user is allowed to create new events.
  def can_create_events?(user)
    #TODO
  end

  #Returns the correct dashboard path based on the user’s role.
  def dashboard_path_for(user)
    #TODO: No dashboard yet
  end

  #Returns a list of navigation links appropriate to the user’s role.
  def navigation_links_for(user)
    #TODO
  end

  #Returns the best name to show for a user (name or email fallback).
  def user_display_name(user)
    if user.name.present?
      return user.name
    elsif user.email.present?
      return user.email
    else
      return ""
  end

  #Returns initials for avatar placeholders.
  def user_initials(user)
    return "#{User.first_name[0]}.#{User.last_name[0]}" 
  end

end
