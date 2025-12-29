require "rails_helper"

RSpec.describe Event, type: :model do
  let(:user) do
    User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  it "is valid with required fields" do
    event = Event.new(
      title: "Soccer",
      category: :sports,
      starts_at: 1.day.from_now,
      allowed_gender: :any,
      rsvp: :public_event,
      user: user
    )

    expect(event).to be_valid
  end

  it "is invalid without a title" do
    event = Event.new(
      title: nil,
      category: :sports,
      starts_at: 1.day.from_now,
      allowed_gender: :any,
      rsvp: :public_event,
      user: user
    )

    expect(event).not_to be_valid
  end
end
