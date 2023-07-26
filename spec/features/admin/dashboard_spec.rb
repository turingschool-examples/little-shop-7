require "rails_helper"

RSpec.describe "Admin Dashboard Page", type: :feature do
#   19. Admin Dashboard

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
  describe "When I visit the admin dashboard (/admin)" do
    it "I see a header indicating that I am on the admin dashboard" do

      visit admin_dashboard_index_path

      expect(page).to have_content("Admin Dashboard")
    end
  end

end
