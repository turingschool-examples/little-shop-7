require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit my items index page" do
    it "Then next to each item I see a button to disable or enable that item" do
      merchant = create(:merchant)
      items = create_list(:item, 4, merchant: merchant)

      visit merchant_items_path(merchant)
      
        items.each do |item|
          expect(page).to have_css("##{item.id}_button")
      end
    end
    
    it "When I click this button, Then I am redirected back to the items index page where I see the item's status has changed" do
      merchant = create(:merchant)
      items = create_list(:item, 4, merchant: merchant)

      visit "/merchants/#{merchant.id}/items" 
      # visit  merchant_items_path(merchant)

      find_button("Disable", id: "#{items.first.id}_button")      
      
      click_button "Disable", id: "#{items.first.id}_button"
      save_and_open_page
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      expect(page).to have_no_button("Disable", id: "#{items.first.id}_button")
      expect(page).to have_button("Enable", id: "#{items.first.id}_button")
    end
  end
end
