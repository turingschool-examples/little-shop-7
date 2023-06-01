require "rails_helper"

RSpec.describe "Admin Dashboard" do
  describe "When I visit the admin dashboard (/admin)" do
    it "displays the admin dashboard" do
      visit "/admin"
      expect(page).to have_content("Admin Dashboard")
    end
  end
end