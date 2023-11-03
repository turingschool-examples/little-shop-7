require "rails_helper"

RSpec.describe "merchant item edit page" do
  before :each do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
  end

  # US8
  it "has a form to update this item, filled in with existing info" do
    visit edit_merchant_item_path(@merchant_1, @item_1)
  end

  # US8
  it "updates the item, redirects to merchant item show page, and shows a flash message" do
    visit edit_merchant_item_path(@merchant_1, @item_1)
  end

  # US8
  it "does not submit when info is not entered" do
    visit edit_merchant_item_path(@merchant_1, @item_1)
  end
end