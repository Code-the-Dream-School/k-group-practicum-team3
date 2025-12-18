class Event < ApplicationRecord
    belongs_to :organizer, class_name: "User"
    enum category: { sports: 0, tutoring: 1, music: 2, arts: 3, dance: 4, language: 5, stem: 6, outdoor: 7, other: 8 }
    enum allowed_gender: { any: 0, male_only: 1, female_only: 2 }

    validates :title, :starts_at, :category, :allowed_gender, presence: true
    validates :age_min, numericality: { only_integer: true, allow_nil: true }
    validates :age_max, numericality: { only_integer: true, allow_nil: true }
end
