require 'rails_helper'

RSpec.describe "Items Show", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 1234)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_2.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "When I visit the items show page" do
    it "I see all attributes of the item, including name, description, unit price and merchant id" do
      visit "/items/#{@item_1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_content(@item_1.merchant_id)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_2.description)
      expect(page).to_not have_content(@item_2.unit_price)
      expect(page).to_not have_content(@item_2.merchant_id)
    end
  end
end