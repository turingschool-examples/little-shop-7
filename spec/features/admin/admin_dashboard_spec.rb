require 'rails_helper'

RSpec.describe "admin dashboard" do
  describe 'it exists' do
    it 'has a header' do

      visit admin_path

      expect(page).to have_content("Admin Dashboard")
    end

    it "has links to admin merchants and routes a user" do 

      visit admin_path

      expect(page).to have_link("Admin Merchants")

      click_link ("Admin Merchants")

      expect(current_path).to eq(admin_merchants_path)
    end 

    it "has links to admin invoices and routes a user" do 

      visit admin_path

      expect(page).to have_link("Admin Invoices")

      click_link ("Admin Invoices")

      expect(current_path).to eq(admin_invoices_path)
    end 




  end
end