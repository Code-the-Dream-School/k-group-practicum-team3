require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "associations" do
    it "belongs to optional resource" do
      role = described_class.create!(name: 'admin')
      expect(role.resource).to be_nil
    end
  end

  describe "validations" do
    it "validates presence of name" do # rubocop:disable RSpec/MultipleExpectations
      role = described_class.new(name: nil)
      expect(role).not_to be_valid
      expect(role.errors[:name]).to include("can't be blank")
    end

    it "accepts valid name" do
      role = described_class.new(name: 'student')
      expect(role).to be_valid
    end
  end

  describe "role-user association" do
    let(:user) do
      User.create!(
        first_name: "Sam",
        last_name: "Smith",
        email: "sam@example.com",
        gender: :male,
        password: "password",
        password_confirmation: "password",
        city: "Some City",
        state: "Some State",
        zip: "12345"
      )
    end

    it "adds student role to user" do
      user.add_role :student
      expect(user).to have_role(:student)
    end

    it "adds parent role to user" do
      user.add_role :parent
      expect(user).to have_role(:parent)
    end

    it "removes role from user" do
      user.add_role :student
      user.remove_role :student
      expect(user).not_to have_role(:student)
    end
  end
end
