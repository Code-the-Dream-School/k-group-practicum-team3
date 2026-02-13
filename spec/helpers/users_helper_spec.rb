require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) do
    User.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      gender: :male,
      password: "password",
      password_confirmation: "password",
      city: "Some City",
      state: "Some State",
      zip: "12345"
    )
  end

  describe "#can_manage_event?" do
    it "returns true when event user_id matches user id" do
      user = instance_double(User, id: 1)
      event = instance_double(Event, user_id: 1)

      expect(helper.can_manage_event?(event, user)).to be(true)
    end

    it "returns false when event user_id does not match user id" do
      user = instance_double(User, id: 1)
      event = instance_double(Event, user_id: 2)

      expect(helper.can_manage_event?(event, user)).to be(false)
    end
  end

  describe "#user_display_name" do
    it "returns the name if present" do
      expect(helper.user_display_name(user)).to eq("John Doe")
    end

    it "falls back to email if name is missing" do
      user.update(first_name: nil, last_name: nil)
      expect(helper.user_display_name(user)).to eq("john@example.com")
    end
  end

  describe "#display_role" do
    it "returns Admin when user has admin role" do
      user.add_role :admin
      expect(helper.display_role(user)).to eq("Admin")
    end

    it "returns default role student when none is selected" do
      expect(helper.display_role(user)).to eq("Student")
    end
  end
end
