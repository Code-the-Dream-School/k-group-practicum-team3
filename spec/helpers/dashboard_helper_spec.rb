require "rails_helper"

RSpec.describe DashboardHelper, type: :helper do
    let!(:organizer) {
        User.create!(
        email: "org@example.com",
        password: "test123",
        first_name: "org",
        last_name: "lastname",
        city: "Chicago",
        state: "IL",
        zip: "60601"
        )
    }

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

    let!(:event) do
        attrs = {
        user: organizer,
        title: "Test Event",
        category: :other
        }
        attrs[:starts_at] = 1.day.from_now if Event.new.respond_to?(:starts_at)
        attrs[:max_capacity] = 2 if Event.new.respond_to?(:max_capacity)
        Event.create!(attrs)
    end


    describe "#num_of_participants" do
    it "returns 0 when event has no enrollments" do
      expect(helper.num_of_participants(event)).to eq(0)
    end

    it "returns the correct count when event has enrollments" do
        Enrollment.create!(user: user, event: event)

        expect(helper.num_of_participants(event)).to eq(1)
    end
  end
end
