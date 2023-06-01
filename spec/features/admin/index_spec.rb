require "rails_helper"

RSpec.describe "Admin Dashboard Index Page" do
  before(:each) do

  end

  describe "Admin Dashboard Display" do
    
    # User Story 19
    it "displays a header indicating that it is the admin dashboard" do
      visit admin_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
end