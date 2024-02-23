require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
  let!(:merchant_1) { Merchant.create!(name: "John Doe")}

  let!(:item1) { merchant_1.items.create!(name: "test", description: "im a good item", unit_price: 31211)}
  let!(:item2) { merchant_1.items.create!(name: "test2", description: "im a better item", unit_price: 41211, status: 1)}
  describe "merchant index" do
    it "shows specific merchant items" do
      visit merchant_items_path(merchant_id: merchant_1.id)

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)

    end

    it "can enable or disable a passport" do
      visit merchant_items_path(merchant_id: merchant_1.id)
      expect(page).to have_content(item1.name)

      expect(page).to have_content(item2.name)
      
    
      first(:button, "Enable").click
    

      expect(page).to have_button("Disable")
  

      expect(current_path).to eq(merchant_items_path(merchant_id: merchant_1.id))
    

    end

    it "separates disabled and enabled" do
      visit merchant_items_path(merchant_id: merchant_1.id)
      
      within("#disabled") do
      

        expect(page).to have_button("Enable")
      end
      within("#enabled") do
      

        expect(page).to have_button("Disable")
      end
      

    end
  end
end
