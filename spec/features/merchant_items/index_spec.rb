require 'rails_helper'

RSpec.describe "MerchantItems Index", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)
    @item_7 = create(:item, merchant_id: @merchant_2.id)
    @item_8 = create(:item, merchant_id: @merchant_2.id)
    @item_9 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "When I visit the merchantitems index page" do
    it "I see a list of all items associated with the current merchant, without items for other merchants" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
      expect(page).to_not have_content(@item_7.name)
      expect(page).to_not have_content(@item_8.name)
      expect(page).to_not have_content(@item_9.name)
    end
  end
end