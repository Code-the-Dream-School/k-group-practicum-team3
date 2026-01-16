require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  describe "#edit?" do
    it "allows owner" do
      owner  = instance_double(User, id: 1)
      record = instance_double(User, id: 1)
      expect(described_class.new(owner, record).edit?).to be(true)
    end

    it "denies non-owner" do
      user   = instance_double(User, id: 2)
      record = instance_double(User, id: 1)
      expect(described_class.new(user, record).edit?).to be(false)
    end

    it "denies nil user" do
      record = instance_double(User, id: 1)
      expect(described_class.new(nil, record).edit?).to be(false)
    end
  end

  describe "#update?" do
    it "allows owner" do
      owner  = instance_double(User, id: 1)
      record = instance_double(User, id: 1)
      expect(described_class.new(owner, record).update?).to be(true)
    end
  end
end
