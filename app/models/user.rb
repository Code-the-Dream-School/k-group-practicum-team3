class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_events, through: :enrollments, source: :event

  # Returns initials for avatar placeholders.
  def user_initials(user)
    "#{User.first_name[0]}.#{User.last_name[0]}"
  end

  # Note: This provides two ways of accessing the data
  # Returns the user full name
  def name
    "#{User.first_name} #{User.last_name}"
  end

  # Returns the users full name given a user
  def name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
