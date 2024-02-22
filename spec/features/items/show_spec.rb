require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
  let!(:merchant_1) { Merchant.create!(name: "John Doe")}
  let!(:item1) { merchant_1.items.create!(name: "test", description: "im a good item", unit_price: 31211)}
  
  describe "merchant index" do
    it "shows specific merchant items" do
      visit merchant_items_path(merchant_id: merchant_1.id)
      expect(page).to have_content(item1.name)

      click_on item1.name
    
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.unit_price)

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item1.id}")
      

    end
  end
end
