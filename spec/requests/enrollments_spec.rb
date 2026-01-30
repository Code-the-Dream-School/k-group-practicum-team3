require "rails_helper"

RSpec.describe "Enrollments", type: :request do
  let!(:organizer) do
    User.create!(
      email: "org@example.com",
      password: "test123",
      first_name: "org",
      last_name: "lastname",
      city: "some city",
      state: "some state",
      zip: 123
    )
  end

  let!(:user) do
    User.create!(
      email: "user@example.com",
      password: "test123",
      first_name: "firstname",
      last_name: "lastname",
      city: "some city",
      state: "some state",
      zip: 123
    )
  end

  let!(:another_user) do
    User.create!(
      email: "another_user@example.com",
      password: "test123",
      first_name: "firstname",
      last_name: "lastname",
      city: "some city",
      state: "some state",
      zip: 123
    )
  end

  let!(:event) do
    attrs = { user: organizer,
              title: "Test Event",
              category: :other
        }
    attrs[:starts_at] = 1.day.from_now if Event.new.respond_to?(:starts_at)
    attrs[:max_capacity]  = 2 if Event.new.respond_to?(:max_capacity)
    Event.create!(attrs)
  end

  before { sign_in user }

  describe "POST /events/:event_id/enrollments" do
    it "creates an enrollment for the current user and event" do
      expect {
        post event_enrollments_path(event)
      }.to change(Enrollment, :count).by(1)
    end
  end

  describe "DELETE /events/:event_id/enrollments/:id" do
    let!(:enrollment) { Enrollment.create!(user: user, event: event) }

    it "removes the enrollment for the current user" do
      expect {
        delete event_enrollment_path(event, enrollment)
      }.to change(Enrollment, :count).by(-1)
    end

    it "does not allow a user to delete another user's enrollment" do
      other_enrollment = Enrollment.create!(user: another_user, event: event)
      delete event_enrollment_path(event, other_enrollment)

      expect(Enrollment.exists?(other_enrollment.id)).to be(true)
    end
  end
end
