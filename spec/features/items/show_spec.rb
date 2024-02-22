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

    
    it "can update specific merchant items" do
        visit merchant_items_path(merchant_id: merchant_1.id)
        expect(page).to have_content(item1.name)

        expect(page).to have_content(item1.name)
        click_on item1.name
        
        click_on "Update"
      
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item1.id}/edit")
        
        fill_in("name", with: "")
        fill_in("name", with: "Alex")
        fill_in("description", with: "")
        fill_in("description", with: "Im CooL")
        fill_in("unit_price", with: "")
        fill_in("unit_price", with: 12345)
        click_button("Save")

        expect(page).to have_content("Item successfully updated.")

        expect(page).to have_content("Alex")
        expect(page).to have_content("Im CooL")
        expect(page).to have_content(12345)

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item1.id}")
      
  
    end
  end
end
