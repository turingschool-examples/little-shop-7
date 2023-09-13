require "rails_helper"

RSpec.describe "merchant#show" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "John Jacob Astor")
    @item_1 = @merchant_1.items.create!(name: "fur coat", description: "a fur coat acquired ethically and legally", unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: "opium", description: "only the finest, acquired ethically and legally", unit_price: 2000)
    @item_3 = @merchant_1.items.create!(name: "land tract", description: "prime real estate in the future home of astoria queens", unit_price: 5000)
  end

  describe "display merchant info" do
    it "has merchant info listed " do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
      within("#merchant_info-#{@merchant_1.id}") do 
        expect(page).to have_content(@merchant_1.name)
      end
    end

    it "has links to a merchant's items and invoices" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#items_index-#{@merchant_1.id}") do
        expect(page).to have_link("Items")
      end
      within("#invoices_index-#{@merchant_1.id}") do
        expect(page).to have_link("Invoices")
      end
    end
  end
end