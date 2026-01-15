require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe "validations" do
    let(:organizer) do
      User.create!(
        first_name: "Org",
        last_name: "User",
        email: "org@test.com",
        password: "pass123",
        location_type: :online
      )
    end

    let(:user) do
      User.create!(
        first_name: "John",
        last_name: "Doe",
        email: "user@test.com",
        password: "pass123",
        location_type: :online
      )
    end

    let(:event_attrs) do
      {
        user: organizer,
        title: "Soccer",
        category: :sports,
        allowed_gender: :any,
        rsvp: :public_event,
        starts_at: 1.day.from_now
      }
    end

    let(:event) { Event.create!(event_attrs) }

    it "does not allow the same user to enroll in the same event twice" do
      Enrollment.create!(user: user, event: event)

      duplicate = Enrollment.new(user: user, event: event)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to be_present
    end
  end
end
