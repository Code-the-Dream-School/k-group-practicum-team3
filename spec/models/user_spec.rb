require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(
      email: "user@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    expect(user).to be_valid
  end
end

