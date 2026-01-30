require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "associations" do
    it "belongs to a user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it "belongs to an event" do
      assoc = described_class.reflect_on_association(:event)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    before do
      create(:favorite, user: user, event: event)
    end

    it "does not allow duplicate favorites" do
      duplicate = build(:favorite, user: user, event: event)
      expect(duplicate).not_to be_valid
    end

    it "adds an error when duplicate favorite is attempted" do
      duplicate = build(:favorite, user: user, event: event)
      duplicate.validate
      expect(duplicate.errors[:user_id]).to include("has already been taken")
    end
  end
end
