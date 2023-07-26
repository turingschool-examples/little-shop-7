require "rails_helper"

RSpec.describe "Admin Dashboard Page", type: :feature do
# US 19
  describe "When I visit the admin dashboard (/admin)" do
    it "I see a header indicating that I am on the admin dashboard" do

      visit admin_dashboard_index_path

      expect(page).to have_content("Admin Dashboard")
    end
  end

end
