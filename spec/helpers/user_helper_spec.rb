require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UserHelper, type: :helper do

  describe "#can_manage_event?" do
    it "returns true when event user_id matches user id" do
      user = instance_double(User, id: 1)
      event = instance_double(Event, user_id: 1)

      expect(helper.can_manage_event?(event, user)).to be(true)
    end

    it "returns false when event user_id does not match user id" do
      user = instance_double(User, id: 1)
      event = instance_double(Event, user_id: 2)

      expect(helper.can_manage_event?(event, user)).to be(false)
    end
  end
end
