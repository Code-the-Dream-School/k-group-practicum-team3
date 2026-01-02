require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = described_class.new(
      email: "user@example.com",
      password: "password123"
    )

    expect(user).to be_valid
  end

  describe 'validations' do
    it 'validates presence of first_name' do
      user = described_class.new(first_name: nil, last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online)
      expect(user).not_to be_valid
    end

    it 'validates presence of last_name' do
      user = described_class.new(first_name: 'John', last_name: nil, email: 'test@test.com', password: 'pass123', location_type: :online)
      expect(user).not_to be_valid
    end

    describe 'age validation' do
      it 'accepts valid ages' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, age: 25)
        user.validate
        expect(user.errors[:age]).to be_empty
      end

      it 'rejects negative ages' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, age: -1)
        expect(user).not_to be_valid
      end

      it 'rejects ages over 150' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, age: 151)
        expect(user).not_to be_valid
      end

      it 'accepts nil age' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, age: nil)
        user.validate
        expect(user.errors[:age]).to be_empty
      end
    end

    describe 'phone validation' do
      it 'accepts phone with dashes' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, phone: '123-456-7890')
        user.validate
        expect(user.errors[:phone]).to be_empty
      end

      it 'accepts phone with parentheses' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, phone: '(123) 456-7890')
        user.validate
        expect(user.errors[:phone]).to be_empty
      end

      it 'accepts phone with spaces and plus' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, phone: '+1 123 456 7890')
        user.validate
        expect(user.errors[:phone]).to be_empty
      end

      it 'rejects invalid phone formats' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, phone: 'abc-def-ghij')
        expect(user).not_to be_valid
      end

      it 'accepts blank phone' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, phone: '')
        user.validate
        expect(user.errors[:phone]).to be_empty
      end
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

    describe 'location validations' do
      it 'requires city and state for in_person users' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :in_person, city: nil, state: nil, zip: '10001')
        expect(user).not_to be_valid
      end

      it 'requires city and state for hybrid users' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :hybrid, city: nil, state: nil, zip: '10001')
        expect(user).not_to be_valid
      end

      it 'does not require location for online users' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :online, city: nil, state: nil, zip: nil)
        user.validate
        expect(user.errors[:city]).to be_empty
      end

      it 'requires zip code for in_person users' do
        user = described_class.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'pass123', location_type: :in_person, city: 'NYC', state: 'NY', zip: nil)
        expect(user).not_to be_valid
      end
    end
  end

  describe 'enums' do
    it 'has in_person location_type' do
      expect(described_class.location_types['in_person']).to eq(0)
    end

    it 'has online location_type' do
      expect(described_class.location_types['online']).to eq(1)
    end

    it 'has hybrid location_type' do
      expect(described_class.location_types['hybrid']).to eq(2)
    end

    it 'has male gender' do
      expect(described_class.genders['male']).to eq(0)
    end

    it 'has female gender' do
      expect(described_class.genders['female']).to eq(1)
    end

    it 'has non_binary gender' do
      expect(described_class.genders['non_binary']).to eq(2)
    end

    it 'has prefer_not_to_say gender' do
      expect(described_class.genders['prefer_not_to_say']).to eq(3)
    end
  end

  describe '#full_name' do
    it 'returns first and last name combined' do
      user = described_class.new(first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '#requires_location?' do
    it 'returns true for in_person users' do
      user = described_class.new(location_type: :in_person)
      expect(user.send(:requires_location?)).to be(true)
    end

    it 'returns true for hybrid users' do
      user = described_class.new(location_type: :hybrid)
      expect(user.send(:requires_location?)).to be(true)
    end

    it 'returns false for online users' do
      user = described_class.new(location_type: :online)
      expect(user.send(:requires_location?)).to be(false)
    end
  end
end
