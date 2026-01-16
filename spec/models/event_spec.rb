require "rails_helper"

RSpec.describe Event, type: :model do
  describe "date/time edge cases" do
    let(:user) do
      User.create!(
        email: "organizer@example.com",
        password: "password123",
        first_name: "John",
        last_name: "Doe",
        city: "Chicago",
        state: "IL",
        zip: "60601",
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

    it "is valid when ends_at is nil" do
      event = described_class.new(base_attrs.merge(starts_at: 1.day.from_now, ends_at: nil))
      expect(event).to be_valid
    end

    it "is invalid when ends_at is before starts_at" do
      event = described_class.new(base_attrs.merge(starts_at: 1.day.from_now, ends_at: 1.hour.from_now))
      event.validate
      expect(event.errors[:ends_at]).to include("must be later than the start time")
    end

    it "is invalid when ends_at equals starts_at" do
      time = 1.day.from_now
      event = described_class.new(base_attrs.merge(starts_at: time, ends_at: time))
      event.validate
      expect(event.errors[:ends_at]).to include("must be later than the start time")
    end

    it "is valid when event crosses midnight (ends the next day)" do
      starts = Time.zone.local(2026, 1, 5, 22, 0, 0)
      ends   = Time.zone.local(2026, 1, 6, 2, 0, 0)

      event = described_class.new(base_attrs.merge(starts_at: starts, ends_at: ends))
      expect(event).to be_valid
    end

    it "is valid for an all-day style event (start of day to end of day)" do
      day = Date.new(2026, 1, 5).in_time_zone
      starts = day.beginning_of_day
      ends   = day.end_of_day

      event = described_class.new(base_attrs.merge(starts_at: starts, ends_at: ends))
      expect(event).to be_valid
    end
  end

  describe "#past?" do
    let(:user) do
      User.create!(
        email: "organizer@example.com",
        password: "password123",
        first_name: "John",
        last_name: "Doe",
        city: "Chicago",
        state: "IL",
        zip: "60601",
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
