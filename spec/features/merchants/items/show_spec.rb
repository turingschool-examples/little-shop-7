require "rails_helper"

RSpec.describe "Merchant Items Show Page" do
  describe "UserStory 8" do
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    it "has a link of the item name" do
      @merchant = create(:merchant)
      @item = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)

      visit merchant_item_path(@merchant, @item)

      expect(page).to have_link("#{@item.name} update information")

      click_on("#{@item.name} update information")
      
      expect(current_path).to eq(edit_merchant_item_path(@merchant, @item))

      fill_in 'Name', with: 'Fancy Shirt'
      fill_in 'Description', with: 'This is a fancy shirt'
      
      click_on 'Update Item' 
      
      expect(current_path).to eq("/merchants/#{@item.merchant.id}/items/#{@item.id}")
      save_and_open_page
      expect(page).to have_content('Fancy Shirt')
      expect(page).to have_content('This is a fancy shirt')
      expect(page).to have_content('Item information was successfully updated.')
    end
  end

end