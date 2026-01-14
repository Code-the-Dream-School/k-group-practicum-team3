require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) {
    User.create!(
      first_name: "Test",
      last_name: "User",
      city: "Norman",
      state: "TX",
      zip: "11111",
      email: "testemail@email.com",
      password: "password"
    )
  }

  let (:event1) {
    Event.create!(
      title: "Test One",
      starts_at: "12/1/26",
      category: 1,
      allowed_gender: 1,
      rsvp: 1,
      location: "online",
      user_id: user.id
    )
  }

  let (:event2) {
    Event.create!(
      title: "Test Two",
      starts_at: "12/1/26",
      category: 3,
      allowed_gender: 0,
      rsvp: 0,
      user_id: user.id
    )
  }

  describe "/index displays the event titles" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "returns the first event title in events#index" do
      get "/events/index"
      expect(response.body).to include("Test One")
    end

    it "returns the second event title in events#index" do
      get "/events/index"
      expect(response.body).to include("Test Two")
    end
  end

  describe "/show/1 displays event information" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "return the title for the event id" do
      get "/events/1"
      expect(response.body).to include("Test One")
    end

    it "returns the location for the event id" do
      get "/events/1"
      expect(response.body).to include("online")
    end
  end

  describe "/1/edit displays the edit page" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "returns the page title" do
      get "/events/1/edit"
      expect(response.body).to include("Edit Event")
    end
  end

  # Pages can be accessed
  describe "GET /index" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "returns http success" do
      get "/events"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "returns http success" do
      get "/events/#{event1.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    before do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "returns http success" do
      get "/events/#{event1.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
