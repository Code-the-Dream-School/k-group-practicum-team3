require "rails_helper"

RSpec.describe Enrollment, type: :model do
  it "associates user and event" do
    enrollment = build(:enrollment)
    expect(enrollment).to respond_to(:event)
  end
end
