require "rails_helper"

RSpec.describe User, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it "is valid with email and password" do
    user = described_class.new(
      email: "user@example.com",
      password: "password123",
      first_name: "Test",
      last_name: "User",
      location_type: :online
    )

    expect(user).to be_valid
  end
  # rubocop:enable RSpec/ExampleLength
end
