module EventHelper
  def self.allowed_gender_options
    Event.allowed_gender.keys.map do |key|
      [t("activerecord.models.event.allowed_gender.#{key}"), key ]
    end
  end
end