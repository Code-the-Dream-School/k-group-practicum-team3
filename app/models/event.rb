class Event < ApplicationRecord
    belongs_to :user
    has_many :enrollments, dependent: :destroy
    has_many :participants, through: :enrollments, source: :user

    enum :category, { sports: 0, tutoring: 1, music: 2, arts: 3, dance: 4, language: 5, stem: 6, outdoor: 7, other: 8 }

    enum :allowed_gender, { any: 0, male_only: 1, female_only: 2 }

    enum :rsvp, { public_event: 0, private_event: 1 }

    validates :title, :starts_at, :category, :allowed_gender, :rsvp, presence: true
    validates :min_age, numericality: { only_integer: true, allow_nil: true }
    validates :max_age, numericality: { only_integer: true, allow_nil: true }

    validates :max_capacity,
            numericality: { only_integer: true, greater_than: 0 },
            allow_nil: true
end
