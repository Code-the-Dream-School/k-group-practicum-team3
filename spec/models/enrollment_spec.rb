require 'rails_helper'

require "rails_helper"

RSpec.describe Enrollment, type: :model do
  let!(:organizer) do
    User.create!(
      email: "org@example.com",
      password: "test123",
      first_name: "Org",
      last_name: "User"
    )
  end

  let!(:user) do
    User.create!(
      email: "user@example.com",
      password: "test123",
      first_name: "Test",
      last_name: "User"
    )
  end

  let!(:event) do
    attrs = { user: organizer, title: "Test Event", category: :other }
    attrs[:starts_at] = 1.day.from_now if Event.new.respond_to?(:starts_at)
    Event.create!(attrs)
  end

  it "is valid with a user and an event" do
    enrollment = described_class.new(user: user, event: event)
    expect(enrollment).to be_valid
  end
end
