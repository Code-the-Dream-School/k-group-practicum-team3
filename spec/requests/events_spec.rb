require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, :with_organizer_role, password: password) }

  let!(:first_event) { create(:event, user: user, title: "Test One", starts_at: 1.day.from_now, location: "online") }
  let!(:second_event) { create(:event, user: user, title: "Test Two", starts_at: 2.days.from_now) }

  def sign_in_via_post!(user, password)
    post user_session_path, params: {
      user: {
        email: user.email,
        password: password
      }
    }
  end

  describe "GET /events" do
    it "renders the index page" do
      get events_path
      expect(response).to have_http_status(:ok)
    end

    it "includes event titles" do
      get events_path
      expect(response.body).to include("Test One")
      expect(response.body).to include("Test Two")
    end
  end

  describe "GET /events/:id" do
    it "renders the show page" do
      get event_path(first_event)
      expect(response).to have_http_status(:ok)
    end

    it "includes basic event information" do
      get event_path(first_event)
      expect(response.body).to include("Test One")
      expect(response.body).to include("online")
    end
  end

  describe "GET /events/:id/edit" do
    before do
      sign_in_via_post!(user, password)
    end

    it "renders the edit page" do
      get edit_event_path(first_event)
      expect(response).to have_http_status(:ok)
    end

    it "includes the page title" do
      get edit_event_path(first_event)
      expect(response.body).to include("Edit Event")
    end
  end
end
