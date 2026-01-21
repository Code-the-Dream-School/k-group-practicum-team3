require "rails_helper"

RSpec.describe EnrollmentPolicy, type: :policy do
  let(:organizer) do
    User.create(
      first_name: "Org",
      last_name: "User",
      email: "org@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:non_organizer) do
    User.create(
      first_name: "Non",
      last_name: "Org",
      email: "non@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:owner) do
    User.create(
      first_name: "Owner",
      last_name: "User",
      email: "owner@test.com",
      password: "pass123",
      location_type: :online
    )
  end

  let(:event) do
    Event.create(
      user: owner,
      title: "Test event",
      starts_at: 1.day.from_now,
      ends_at: 2.days.from_now,
      category: :sports,
      allowed_gender: :any,
      rsvp: :public_event
    )
  end

  let(:enrollment) do
    Enrollment.create(
      user: owner,
      event: event
    )
  end

  before do
    organizer.add_role(:organizer)
  end

  it "does not allow unauthenticated user to access new" do
    policy = described_class.new(nil, enrollment)
    expect(policy.new?).to be(false)
  end

  it "does not allow unauthenticated user to access create" do
    policy = described_class.new(nil, enrollment)
    expect(policy.create?).to be(false)
  end

  it "allow authenticated user to access new" do
    policy = described_class.new(non_organizer, enrollment)
    expect(policy.new?).to be(true)
  end

  it "allow authenticated user to access create" do
    policy = described_class.new(non_organizer, enrollment)
    expect(policy.create?).to be(true)
  end

  it "prevents owners from accessing new for their own event" do
    policy = described_class.new(owner, enrollment)
    expect(policy.new?).to be(false)
  end

  it "prevents owners from accessing create for their own event" do
    policy = described_class.new(owner, enrollment)
    expect(policy.create?).to be(false)
  end
end
