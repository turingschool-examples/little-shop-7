require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: nil)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: nil)
    @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: nil)
  end

# As a merchant,
# When I visit my merchant items index page 
# (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant

  describe " when i visit my merchants item index page" do
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1)
      
      expect(page).to have_content("Ball")
      expect(page).to have_content("Disc")
    end
    
    it "doesn't display items for any other merchant" do
      visit merchant_items_path(@merchant_1)
      
      expect(page).to_not have_content("pants")
    end
  end
  
  # 9. Merchant Item Disable/Enable
  # As a merchant
  # When I visit my items index page (/merchants/:merchant_id/items)
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  
  describe "when I visit my items index page" do
    it "displays a button next to each item to enable/disable that item" do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_button("Disable")
    end
  end

end