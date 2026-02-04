class Event < ApplicationRecord
  belongs_to :user
  has_many :enrollments, dependent: :destroy
  has_many :participants, through: :enrollments, source: :user
  has_many_attached :media_files

  enum :category, { sports: 0, tutoring: 1, music: 2, arts: 3, dance: 4, language: 5, stem: 6, outdoor: 7, other: 8 }
  enum :allowed_gender, { any: 0, male_only: 1, female_only: 2 }
  enum :rsvp, { public_event: 0, private_event: 1 }

  validates :title, :starts_at, :category, :allowed_gender, :rsvp, presence: true
  validate :registration_deadline_before_start
  validates :min_age, numericality: { only_integer: true, allow_nil: true }
  validates :max_age, numericality: { only_integer: true, allow_nil: true }
  validates :max_capacity,

            numericality: { only_integer: true, greater_than: 0 },
            allow_nil: true

  validate :ends_at_after_starts_at
  validate :acceptable_media
  validate :media_file_count

  def past?
    (ends_at || starts_at) < Time.current
  end

  def registration_open?
    return false if past?
    return true if registration_deadline.nil?
    registration_deadline > Time.current
  end

  def registration_closed?
    !registration_open?
  end

  # Scopes for filtering
  scope :upcoming, -> { where("COALESCE(ends_at, starts_at) >= ?", Time.current) }
  scope :with_open_registration, -> {
    where("registration_deadline IS NULL OR registration_deadline >= ?", Time.current)
      .where("COALESCE(ends_at, starts_at) >= ?", Time.current)
  }


  private

  def ends_at_after_starts_at
    return if ends_at.blank? || starts_at.blank?

    errors.add(:ends_at, "must be later than the start time") if ends_at <= starts_at
  end

  def acceptable_media
    return unless media_files.attached?

    media_files.each do |file|
      unless file.content_type.in?(%w[image/jpeg image/png image/gif image/webp])
        errors.add(:media_files, "must be JPEG, PNG, GIF, or WEBP")
      end
    end
  end

  def media_file_count
    return unless media_files.attached?

    if media_files.count > 5
      errors.add(:media_files, "cannot have more than 5 images")
    end
  end

  def registration_deadline_before_start
    return if registration_deadline.blank? || starts_at.blank?

    if registration_deadline > starts_at
      errors.add(:registration_deadline, "must be before the event start time")
    end
  end
end
