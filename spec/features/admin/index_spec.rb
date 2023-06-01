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

      expect(page).to have_link("Merchants", href: "/admin/merchants")
      click_on("Merchants")
      expect(page).to have_current_path("/admin/merchants")
    end

    it "displays a link to the admin invoices index page" do
      visit admin_path

      expect(page).to have_link("Invoices", href: "/admin/invoices")
      click_on("Invoices")
      expect(page).to have_current_path("/admin/invoices")
    end
  end
end