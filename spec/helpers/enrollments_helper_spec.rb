require "rails_helper"

RSpec.describe EnrollmentsHelper, type: :helper do
  let!(:organizer) { User.create!(email: "org@example.com", password: "test123", first_name: "org",
    last_name: "lastname", city: "Chicago", state: "IL", zip: "60601", location_type: :online) }
  let!(:user) { User.create!(email: "user@example.com", password: "test123", first_name: "firstname",
    last_name: "lastname", city: "Chicago", state: "IL", zip: "60601", location_type: :online) }

  let!(:event) do
    attrs = { user: organizer,
              title: "Test Event",
              category: :other
        }
    attrs[:starts_at] = 1.day.from_now if Event.new.respond_to?(:starts_at)
    attrs[:max_capacity]  = 2 if Event.new.respond_to?(:max_capacity)
    Event.create!(attrs)
  end

  describe "#enrolled_in?" do
    it "returns false when no enrollment exists" do
      expect(helper.enrolled_in?(event, user)).to be(false)
    end

    it "returns true when enrollment exists" do
      Enrollment.create!(event: event, user: user)
      expect(helper.enrolled_in?(event, user)).to be(true)
    end
  end

  describe "#event_full?" do
    it "returns false when event has no max capacity field" do
      skip "Event has max capacity in this app" if Event.new.respond_to?(:max_capacity)
      expect(helper.event_full?(event)).to be(false)
    end
  end

  describe "#can_enroll?" do
    it "returns false for organizer" do
      organizer.add_role :organizer
      expect(helper.can_enroll?(event, organizer)).to be(false)
    end

    it "returns false if already enrolled" do
      Enrollment.create!(event: event, user: user)
      expect(helper.can_enroll?(event, user)).to be(false)
    end

    it "returns false if event is full (when max capacity exists)" do
      event.update!(max_capacity: 1)
      Enrollment.create!(event: event, user: user)
      another_user = User.create!(email: "u2@example.com", password: "password123", first_name: "U2", last_name: "User", city: "Chicago", state: "IL", zip: "60601", location_type: :online)
      expect(helper.can_enroll?(event, another_user)).to be(false)
    end

    it "returns true when user is not organizer, not enrolled, and event not full" do
      another_user = User.create!(email: "u2@example.com", password: "password123", first_name: "U2", last_name: "User", city: "Chicago", state: "IL", zip: "60601", location_type: :online)
      expect(helper.can_enroll?(event, another_user)).to be(true)
    end
  end

  describe "#enrollment_count" do
    it "returns 0 participants when event is nil" do
      expect(helper.enrollment_count(nil)).to eq("0 participants")
    end

    it "returns 'count / max capacity participants' when max capacity exists" do
      event.update!(max_capacity: 10)
      Enrollment.create!(event: event, user: user)

      expect(helper.enrollment_count(event)).to eq("1 / 10 participants")
    end
  end

  describe "#show_enroll_button?" do
    it "delegates to can_enroll?" do
      organizer.add_role :organizer
      expect(helper.show_enroll_button?(event, organizer)).to be(false)
    end
  end

  describe "#show_leave_button?" do
    it "returns false for organizer" do
      expect(helper.show_leave_button?(event, organizer)).to be(false)
    end

    it "returns true when user is enrolled and not organizer" do
      Enrollment.create!(event: event, user: user)
      expect(helper.show_leave_button?(event, user)).to be(true)
    end
  end

  describe "#enrollment_status_label" do
    it "returns Login required when user is nil" do
      expect(helper.enrollment_status_label(event, nil)).to eq("Login required")
    end

    it "returns Organizer for organizer" do
      organizer.add_role :organizer
      expect(helper.enrollment_status_label(event, organizer)).to eq("Organizer")
    end

    it "returns Enrolled when enrolled" do
      Enrollment.create!(event: event, user: user)
      expect(helper.enrollment_status_label(event, user)).to eq("Enrolled")
    end
  end

  describe "#can_view_participants?" do
    it "returns true for organizer" do
      organizer.add_role :organizer
      expect(helper.can_view_participants?(event, organizer)).to be(true)
    end

    it "returns false for non-organizer" do
      expect(helper.can_view_participants?(event, user)).to be(false)
    end
  end
end
