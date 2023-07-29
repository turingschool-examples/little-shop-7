require 'rails_helper'

RSpec.describe "Admin Merchant Show Page", type: :feature do 
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers")
    @merchant_2 = Merchant.create!(name: "Kwik-E-Mart")
    @merchant_3 = Merchant.create!(name: "Strickland Propane")
  end
  
  describe "When I visit the merchant show page (/admin/merchants/:merchant_id)" do
    it "I see a link to update the merchant's information" do
    
      visit admin_merchant_path(@merchant_1)
      
      expect(page).to have_link('Update Merchant Information')
      expect(page).to have_content("Bob's Burgers")
      expect(page).not_to have_content("Kwik-E-Mart")

      click_link 'Update Merchant Information'
      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
    
      fill_in "merchant[name]", with: "Robert's Hamburgers"
      click_button "Update Merchant"

      expect(page).to have_current_path(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Robert's Hamburgers")
      expect(page).to have_content('Merchant information updated successfully.')
    end
  end

end