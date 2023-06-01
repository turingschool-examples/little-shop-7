require 'rails_helper'

RSpec.describe "Admin Merchant Index Page", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "When I visit the admin merchants index" do
    it "displays the name of each merchant in the system" do
      visit admin_merchants_path
      
      expect(page).to have_content("Admin Merchant Index Page")
      expect(page).to have_content("Merchants:")
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
    end
    
    it "each merchant name is a link to that merchant's show page" do
      visit admin_merchants_path

      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)

      click_link(@merchant_1.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end
end