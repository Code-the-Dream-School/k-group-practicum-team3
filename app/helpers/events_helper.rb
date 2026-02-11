module EventsHelper
  def self.allowed_gender_options
    Event.allowed_gender.keys.map do |key|
      [ t("activerecord.models.event.allowed_gender.#{key}"), key ]
    end
  end

  def event_default_image(event)
    return "other.jpg" if event.nil?

    category = event.category.presence || "other"
    image_name = "#{category}.jpg"

    if asset_exist?(image_name)
      image_name
    else
      "other.jpg"
    end
  end

  private

  def asset_exist?(path)
    Rails.application.assets&.find_asset(path).present? ||
      Rails.application.assets_manifest&.assets&.value?(path)
  end
end
