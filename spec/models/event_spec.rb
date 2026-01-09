require "rails_helper"

RSpec.describe Event, type: :model do
  let(:organizer) { create(:user) }

  it "requires title, starts_at, category, allowed_gender, rsvp" do
    event = build(:event, title: nil, starts_at: nil, category: nil, allowed_gender: nil, rsvp: nil)
    expect(event).not_to be_valid
  end

  it "accepts valid event" do
    event = build(:event, user: organizer)
    event.validate
    expect(event.errors).to be_empty
  end
end
