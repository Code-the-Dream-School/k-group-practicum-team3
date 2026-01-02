require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password", location_type: :online, gender: :male) }

  before do
    sign_in user
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end
end
