require "rails_helper"

RSpec.describe EventPolicy, type: :policy do
  let(:organizer) do
    User.create!(
      first_name: "Org",
      last_name: "User",
      email: "org@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:non_organizer) do
    User.create!(
      first_name: "Non",
      last_name: "Org",
      email: "non@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:owner) do
    User.create!(
      first_name: "Owner",
      last_name: "User",
      email: "owner@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:event) do
    Event.new(
      user: owner,
      title: "Test event",
      starts_at: 1.day.from_now,
      ends_at: 2.days.from_now,
      category: :sports,
      allowed_gender: :any,
      rsvp: :public_event
    )
  end

  before do
    organizer.add_role(:organizer)
  end

  it "allows organizers to access new" do
  policy = described_class.new(organizer, event)
  expect(policy.new?).to be(true)
end

it "allows organizers to access create" do
  policy = described_class.new(organizer, event)
  expect(policy.create?).to be(true)
end

it "denies non-organizers to access new" do
  policy = described_class.new(non_organizer, event)
  expect(policy.new?).to be(false)
end

it "denies non-organizers to access create" do
  policy = described_class.new(non_organizer, event)
  expect(policy.create?).to be(false)
end

it "allows organizers to edit their own events" do
  event.user = organizer
  policy = described_class.new(organizer, event)
  expect(policy.edit?).to be(true)
end

it "allows organizers to update their own events" do
  event.user = organizer
  policy = described_class.new(organizer, event)
  expect(policy.update?).to be(true)
end

it "denies organizers from editing events they do not own" do
  policy = described_class.new(organizer, event) # owner != organizer
  expect(policy.edit?).to be(false)
end

it "denies organizers from updating events they do not own" do
  policy = described_class.new(organizer, event) # owner != organizer
  expect(policy.update?).to be(false)
end

it "denies organizers from editing past events even if they own them" do
  event.user = organizer
  event.ends_at = 1.day.ago

  policy = described_class.new(organizer, event)
  expect(policy.edit?).to be(false)
end

it "denies organizers from updating past events even if they own them" do
  event.user = organizer
  event.ends_at = 1.day.ago

  policy = described_class.new(organizer, event)
  expect(policy.update?).to be(false)
end
end
