require "rails_helper"

RSpec.describe "merchant items index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_5 = create(:item, merchant: @merchant_1)
    @item_6 = create(:item, merchant: @merchant_2)
  end

  # US6
  it "shows the names of all of this merchant's items" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_5.name)
  end

  # US6
  it "does not show the names of items belonging to other merchants" do
    visit merchant_items_path(@merchant_1)
    
    expect(page).to_not have_content(@item_6.name)
  end

  # US7
  it "item names link to merchant item show page" do
    visit merchant_items_path(@merchant_1)

    click_link "#{@item_1.name}"

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
  end

  #US11
  it "has a link to create a new item" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_link("Add Item")

    click_link "Add Item"

    expect(current_path).to eq(new_merchant_item_path)
  end
end