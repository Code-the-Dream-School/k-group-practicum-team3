require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = described_class.new(
      email: "user@example.com",
      password: "password123"
    )

    expect(user).to be_valid
  end
end
