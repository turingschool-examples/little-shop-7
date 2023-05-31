require "rails_helper"

RSpec.describe "/admin", type: :feature do
  describe "admin dashboard" do
    it "will display a header indicating you are on the dashboard" do
      visit admin_path
      
      expect(page).to have_content("Admin Dashboard")
    end
    
    it "should display links to admin/merchants and admin/invoices admin/dashboard" do
      visit admin_path
      save_and_open_page
      expect(page).to have_link("Dashboard", :href => admin_path)
      expect(page).to have_link("Merchants", :href => admin_merchants_path)
      expect(page).to have_link("Invoices", :href => admin_invoices_path)
    end
  end
end