require 'rails_helper'

RSpec.describe Event, type: :model do
   describe "date/time edge cases" do
    let(:user) do
      User.create!(
       first_name: "John",
    last_name: "Doe",
    email: "user@test.com",
    password: "pass123",
    location_type: :online
  )
    end

    it "is valid when ends_at is nil" do
      event = Event.new(
        user: user,
        title: "Soccer",
        category: :sports,
        allowed_gender: :any,
        rsvp: :public_event,
        starts_at: 1.day.from_now,
        ends_at: nil
      )

      expect(event).to be_valid
    end

    it "is invalid when ends_at is before starts_at" do
      event = Event.new(
        user: user,
        title: "Soccer",
        category: :sports,
        allowed_gender: :any,
        rsvp: :public_event,
        starts_at: 1.day.from_now,
        ends_at: 1.hour.from_now
      )

      expect(event).not_to be_valid
      expect(event.errors[:ends_at]).to include("must be after starts_at")
    end
    
    it "is invalid when ends_at equals starts_at" do
      t = 1.day.from_now

      event = Event.new(
        user: user,
        title: "Soccer",
        category: :sports,
        allowed_gender: :any,
        rsvp: :public_event,
        starts_at: t,
        ends_at: t
      )

      expect(event).not_to be_valid
      expect(event.errors[:ends_at]).to include("must be after starts_at")
    end
  end
end
