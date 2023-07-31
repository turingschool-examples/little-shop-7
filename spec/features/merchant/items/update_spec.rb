require "rails_helper"

RSpec.describe "merchant item update page" do
  before(:each) do
    # @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    # @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    # @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: nil)
    # @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: nil)
    # @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: nil)

    @merchant = FactoryBot.create(:merchant)
    @item = FactoryBot.create(:item, merchant: @merchant)
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
      visit merchant_item_path(@merchant, @item)
      
      expect(page).to have_link("Update Item")
    end
    
    it "takes user to and edit page to edit that item when clicked, where it has the existing attributes filled out in the form " do
      visit merchant_item_path(@merchant, @item)

      click_link "Update Item"

      expect(page).to have_current_path(edit_merchant_item_path(@merchant, @item))

      within("form") do
        
        expect(find_field("item_name").value).to eq(@item.name)
        expect(find_field("item_description").value).to eq(@item.description)
        expect(find_field("item_unit_price").value).to eq(@item.unit_price.to_s)
      end
    end

    it "updates the item when user fills in form with new information and redirects back to the item show page" do  
      visit edit_merchant_item_path(@merchant, @item)

        fill_in "Name", with: "Ball"
        fill_in "Description", with: "Round"
        fill_in "Unit price", with: "1000"
        
        click_button "Update Item"

        expect(page).to have_current_path(merchant_item_path(@merchant, @item))
        expect(page).to have_content("Ball")
        expect(page).to have_content("Round")
        expect(page).to have_content("10.00")
    end

    it "displays a flash message that says the 'Item successfully enabled'" do
      disabled = FactoryBot.create(:item, merchant: @merchant, status: 0)
      visit merchant_items_path(@merchant)

      click_button 'Enable'

      expect(page).to have_text("Item successfully enabled.")
      expect(page).to have_current_path(merchant_items_path(@merchant))
    end

    it "displays a flash message that says the user has succesfully update the item information" do
      visit edit_merchant_item_path(@merchant, @item)
      
      fill_in "Name", with: "Ball"
      fill_in "Description", with: "Round"
      fill_in "Unit price", with: "1000"
      
      click_button "Update Item"
      
      expect(page).to have_current_path(merchant_item_path(@merchant, @item))
      expect(page).to have_text("Item successfully updated.")
    end
    
    it "displays a flash message that says 'Failed to update item'" do
      visit edit_merchant_item_path(@merchant, @item)
      
      # Invalid form entry
      fill_in "Name", with: ""
      fill_in "Description", with: "Round"
      fill_in "Unit price", with: "1000"

      click_button "Update Item"

      expect(page).to have_current_path(merchant_item_path(@merchant, @item))
      expect(page).to have_text("Failed to update item.")
    end
  end
end