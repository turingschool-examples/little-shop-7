require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: nil)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 7510, status: nil)
  end

# As a merchant,
# When I visit my merchant items index page 
# (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant

  describe " when i visit my merchants item index page" do
    it "displays a list of the names of all my items" do
      @merchant_1.items << @item_1
      @merchant_1.items << @item_2

      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content("Ball")
      expect(page).to have_content("Disc")
    end
  end


    


end