require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, :with_organizer_role, password: password) }

  let!(:first_event) { create(:event, user: user, title: "Test One", starts_at: 1.day.from_now, location: "online") }

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

    it "includes the first event title" do
      get events_path
      expect(response.body).to include("Test One")
    end

    it "includes the second event title" do
      create(:event, user: user, title: "Test Two", starts_at: 2.days.from_now)

      get events_path
      expect(response.body).to include("Test Two")
    end
  end

  describe "GET /events/:id" do
    it "renders the show page" do
      get event_path(first_event)
      expect(response).to have_http_status(:ok)
    end

    it "includes the event title" do
      get event_path(first_event)
      expect(response.body).to include("Test One")
    end

    it "includes the event location" do
      get event_path(first_event)
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

  describe "event#destroy" do
    it "removes the record from the database" do
      first_event.destroy
      expect { first_event.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
