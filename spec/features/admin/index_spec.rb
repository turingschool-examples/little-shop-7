require "rails_helper"

RSpec.describe "/admin", type: :feature do
  describe "admin dashboard" do
    it "will display a header indicating you are on the dashboard" do
      visit "/admin"
      
      expect(page).to have_content("Admin Dashboard")
    end
  end
end
