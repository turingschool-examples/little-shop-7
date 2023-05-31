require "rails_helper"

RSpec.describe "/admin", type: :feature do
  # 19. Admin Dashboard

  # As an admin,
  # When I visit the admin dashboard (/admin)
  # Then I see a header indicating that I am on the admin dashboard
  describe "admin dashboard" do
    it "will display a header indicating you are on the dashboard" do
      visit "/admin"
      
      expect(page).to have_content("Admin Dashboard")
    end
  end
end