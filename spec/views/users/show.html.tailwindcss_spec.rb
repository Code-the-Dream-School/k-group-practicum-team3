require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
  let(:user) do
    User.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      password: "password",
      password_confirmation: "password",
      location_type: :online,
      gender: :male
    )
  end

  before do
    assign(:user, user)
    render
  end

  it "displays the user's full name" do
    expect(rendered).to match(/John Doe/)
  end

  it "displays the user's email" do
    expect(rendered).to match(/john@example.com/)
  end
end
