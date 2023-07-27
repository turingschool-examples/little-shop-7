require "rails_helper"

RSpec.describe "merchant item update page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: nil)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: nil)
    @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: nil)

    # merchant = FactoryBot.create(:merchant)
    # item = FactoryBot.create(:item, merchant: merchant)
  end

# 8. Merchant Item Update
# As a merchant,
# When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page 
# where I see the updated information
# And I see a flash message stating that the 
# information has been successfully updated.

  describe "when i visit the merchants item show page" do
    it "displays a link to update that items information" do
      visit merchant_item_path(@merchant_1, @item_1)
      
      expect(page).to have_link("Update Item")
    end
  end
end