require "rails_helper"

RSpec.describe "Dashboard" do
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end
end
