require "rails_helper"

RSpec.describe EnrollmentsHelper, type: :helper do
  let!(:organizer) { create(:user, :with_organizer_role) }
  let!(:user)      { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:event)     { create(:event, user: organizer, max_capacity: 2) }

  describe "#enrolled_in?" do
    it "returns false when no enrollment exists" do
      expect(helper.enrolled_in?(event, user)).to be(false)
    end

    it "returns true when enrollment exists" do
      create(:enrollment, event: event, user: user)
      expect(helper.enrolled_in?(event, user)).to be(true)
    end
  end

  describe "#event_full?" do
    it "returns false when event not full" do
      expect(helper.event_full?(event)).to be(false)
    end

    it "returns true when event is full" do
      create(:enrollment, event: event, user: user)
      create(:enrollment, event: event, user: another_user)
      expect(helper.event_full?(event)).to be(true)
    end
  end

  describe "#can_enroll?" do
    it "returns false for organizer" do
      expect(helper.can_enroll?(event, organizer)).to be(false)
    end

    it "returns false if already enrolled" do
      create(:enrollment, event: event, user: user)
      expect(helper.can_enroll?(event, user)).to be(false)
    end

    it "returns false if event is full" do
      create(:enrollment, event: event, user: user)
      create(:enrollment, event: event, user: another_user)
      new_user = create(:user)
      expect(helper.can_enroll?(event, new_user)).to be(false)
    end

    it "returns true when user eligible" do
      new_user = create(:user)
      expect(helper.can_enroll?(event, new_user)).to be(true)
    end
  end
end
