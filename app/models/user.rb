class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  #Returns initials for avatar placeholders.
  def user_initials(user)
    return "#{User.first_name[0]}.#{User.last_name[0]}" 
  end

  #Note: This provides two ways of accessing the data
  #Returns the user full name
  def name
    return "#{User.first_name} #{User.last_name}"
  end

  #Returns the users full name given a user
  def name(user)
    return "#{user.first_name} #{user.last_name}"
  end

end
