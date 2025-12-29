require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:user) { User.create!(email: "organizer@example.com", password: "password123") }

  let(:event) do
    Event.create!(
      title: "Soccer Practice",
      category: :sports,
      starts_at: 1.day.from_now,
      allowed_gender: :any,
      rsvp: :public_event,
      user: user
    )
  end

  it "renders the index page" do
    get events_path
    expect(response).to have_http_status(:ok)
  end

  it "renders the show page" do
    get event_path(event)
    expect(response).to have_http_status(:ok)
  end
end
