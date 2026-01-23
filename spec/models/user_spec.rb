require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires first_name" do
      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
    end

    it "requires last_name" do
      user = build(:user, last_name: nil)
      expect(user).not_to be_valid
    end

    it "accepts valid age" do
      user = build(:user, age: 30)
      user.validate
      expect(user.errors[:age]).to be_empty
    end

    describe 'bio validation' do
      it 'rejects bio over 5000 characters' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, bio: 'a' * 5001)
        expect(user).not_to be_valid
      end

      it 'accepts bio under 5000 characters' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, bio: 'a' * 5000)
        user.validate
        expect(user.errors[:bio]).to be_empty
      end
    end
  end
    it "rejects negative age" do
      user = build(:user, age: -1)
      expect(user).not_to be_valid
    end

    it "rejects age over 150" do
      user = build(:user, age: 151)
      expect(user).not_to be_valid
    end

    it "accepts nil age" do
      user = build(:user, age: nil)
      user.validate
      expect(user.errors[:age]).to be_empty
    end
  end

  describe "#full_name" do
    it "returns first and last name combined" do
      user = build(:user, first_name: "Jane", last_name: "Doe")
      expect(user.full_name).to eq("Jane Doe")
    end
  end
end
