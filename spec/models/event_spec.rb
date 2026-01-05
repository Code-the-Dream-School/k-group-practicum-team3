require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#past?" do
  let(:user) do
    User.create!(
      first_name: "John",
      last_name: "Doe",
      email: "past@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:base_attrs) do
    {
      user: user,
      title: "Soccer",
      category: :sports,
      allowed_gender: :any,
      rsvp: :public_event
    }
  end

  it "returns true when ends_at is in the past" do
    event = described_class.new(base_attrs.merge(starts_at: 2.days.ago, ends_at: 1.day.ago))
    expect(event.past?).to be(true)
  end

  it "returns false when ends_at is in the future" do
    event = described_class.new(base_attrs.merge(starts_at: 1.hour.ago, ends_at: 1.hour.from_now))
    expect(event.past?).to be(false)
  end
end
end
