require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it 'has many users through habtm' do
      role = described_class.new(name: 'student')
      expect(role).to respond_to(:users)
    end

    it 'belongs to optional resource' do
      role = described_class.new(name: 'admin')
      expect(role).to respond_to(:resource)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      role = described_class.new(name: nil)
      expect(role).not_to be_valid
    end

    it 'accepts valid name' do
      role = described_class.new(name: 'student')
      role.validate
      expect(role.errors[:name]).to be_empty
    end
  end

  describe 'role creation' do
    it 'creates student role' do
      role = described_class.create(name: 'student')
      expect(role.name).to eq('student')
    end

    it 'creates parent role' do
      role = described_class.create(name: 'parent')
      expect(role.name).to eq('parent')
    end

    it 'creates organizer role' do
      role = described_class.create(name: 'organizer')
      expect(role.name).to eq('organizer')
    end
  end

  describe 'role user association' do
    let(:user) do
      User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@test.com',
        password: 'pass123',
        location_type: :online
      )
    end

    it 'adds student role to user' do
      user.save
      user.add_role :student
      expect(user.has_role?(:student)).to be(true)
    end

    it 'adds parent role to user' do
      user.save
      user.add_role :parent
      expect(user.has_role?(:parent)).to be(true)
    end

    it 'removes role from user' do
      user.save
      user.add_role :student
      user.remove_role :student
      expect(user.has_role?(:student)).to be(false)
    end
  end
end
