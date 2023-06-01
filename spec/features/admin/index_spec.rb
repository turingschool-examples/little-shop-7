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

    # User Story 20
    it "displays a link to the admin merchants index page" do
      visit admin_path

      expect(page).to have_link("Merchants", href: admin_merchants_path)
      
      click_link("Merchants")
      expect(page).to have_current_path(admin_merchants_path)
    end

    it "displays a link to the admin invoices index page" do
      visit admin_path

      expect(page).to have_link("Invoices", href: admin_invoices_path)
      click_link("Invoices")
      expect(page).to have_current_path(admin_invoices_path)
    end
  end
end