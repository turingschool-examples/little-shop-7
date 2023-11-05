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

  # US11
  it "has a form to create a new item for this merchant" do
    visit new_merchant_item_path(@merchant_1)

    expect(page).to have_field(:name)
    expect(page).to have_field(:description)
    expect(page).to have_field(:unit_price)
    expect(page).to have_button("Add Item")
  end

  # US11
  it "when filled out with valid data, it creates a new item and redirects to index" do
    visit new_merchant_item_path(@merchant_1)

    fill_in :name, with: "Fantastic Fidget"
    fill_in :description, with: "a fantastically fun fidget!"
    fill_in :unit_price, with: 12345
    click_button "Add Item"

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    expect(page).to have_content("Fantastic Fidget")
  end

  # US11
  it "when filled out with invalid data, redirects back with an error" do
    visit new_merchant_item_path(@merchant_1)

    fill_in :name, with: ""
    fill_in :description, with: "a fantastically fun fidget!"
    fill_in :unit_price, with: 12345
    click_button "Add Item"

    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
    expect(page).to have_content("Error: fgdfgfg")
  end
end