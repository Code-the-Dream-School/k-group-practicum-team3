class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Rolify
  rolify

  # Virtual attribute (signup only)
  attr_accessor :requested_role
  after_create :assign_role_from_signup

  # Enums
  enum :gender, { male: 0, female: 1, non_binary: 2, prefer_not_to_say: 3 }

  # Associations for Events
  # Active Storage
  has_one_attached :profile_picture
  # As participant
  # Enrollments I have made
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_events, through: :enrollments, source: :event
  # As organizer
  has_many :organized_events, class_name: "Event", foreign_key: "user_id", dependent: :destroy

  # Favorites
  has_many :favorites, dependent: :destroy
  has_many :favorited_events, through: :favorites, source: :event

  # Validations
  validates :first_name, :last_name, presence: true
  validates :age, allow_nil: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 150
  }
  validates :phone, allow_blank: true, format: { with: /\A[\d\s\-\+\(\)]+\z/, message: "invalid format" }
  validates :bio, length: { maximum: 5000 }, allow_blank: true

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    has_role?(:admin)
  end

  private

  def assign_role_from_signup
    allowed_roles = %w[student parent organizer ]

    role =
      if requested_role.present? && allowed_roles.include?(requested_role)
        requested_role
      else
        "student"
      end

    add_role(role)
  end

  # Returns initials for avatar placeholders.
  def user_initials(user)
    "#{first_name.first}.#{last_name.first}"
  end

  # Note: This provides two ways of accessing the data
  # Returns the user full name
  def name
    "#{first_name.first} #{last_name.first}"
  end
end
