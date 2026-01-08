require "rails_helper"

RSpec.describe Role, type: :model do
  describe "associations" do
    it "has many users" do
      role = build(:role)
      expect(role).to respond_to(:users)
    end

    it "belongs to optional resource" do
      role = build(:role)
      expect(role).to respond_to(:resource)
    end
  end

  describe "validations" do
    it "requires name" do
      role = build(:role, name: nil)
      expect(role).not_to be_valid
    end

    it "accepts valid name" do
      role = build(:role, name: "student")
      role.validate
      expect(role.errors[:name]).to be_empty
    end
  end
end
