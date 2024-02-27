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

    it "can create a new item" do
      visit merchant_items_path(merchant_id: merchant_1.id)

      click_on ("Create Item")

      fill_in("name", with: "testitem")
      fill_in("description", with: "test is good")
      fill_in("unit_price", with: "22112")

      click_button("Submit")

      visit merchant_items_path(merchant_id: merchant_1.id)


      expect(current_path).to eq(merchant_items_path(merchant_id: merchant_1.id))
      expect(page).to have_content("testitem")
      
    end

    
  end
  describe '#calculate_top_items' do
    it 'returns the top 5 items by revenue' do
      merchant = create(:merchant) 
      items = create_list(:item, 10, merchant: merchant) 
      items.each do |item|
        invoice = create(:invoice)
        transaction = create(:transaction, invoice: invoice, result: 'success')
        create(:invoice_item, item: item, invoice: invoice, quantity: 2, unit_price: 10)
      end
      visit merchant_items_path(merchant_id: merchant.id)
      top_items = merchant.calculate_top_items
      
      expect(page).to have_content(top_items.first.name)
      expect(page).to have_content(top_items[1].name)
      expect(page).to have_content(top_items[3].name)
      expect(page).to have_content(top_items[2].name)
      expect(page).to have_content(top_items[4].name)
    

      first(:link, top_items[0].name).click
      
      
      
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{top_items[0].id}")
      
    end
  end
end
