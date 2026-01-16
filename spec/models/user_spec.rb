require 'rails_helper'

RSpec.describe User, type: :model do
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
  end

  describe '#full_name' do
    it 'returns first and last name combined' do
      user = described_class.new(first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end
end
