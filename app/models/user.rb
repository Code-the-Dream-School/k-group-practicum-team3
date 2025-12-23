class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum :location_type, { in_person: 0, online: 1, hybrid: 2 }
  enum :gender, { male: 0, female: 1, non_binary: 2, prefer_not_to_say: 3 }

  # Active Storage
  has_one_attached :profile_picture

  # Validations
  validates :first_name, :last_name, presence: true

  validates :age,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 150
            },
            allow_nil: true

  validates :phone,
            format: { with: /\A[\d\s\-\+\(\)]+\z/, message: "invalid format" },
            allow_blank: true

  validates :bio, length: { maximum: 5000 }, allow_blank: true

  validates :location_type, presence: true
  validates :city, :state, :zip, presence: true, if: :requires_location?

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def requires_location?
    in_person? || hybrid?
  end
end
