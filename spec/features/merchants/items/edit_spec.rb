require "rails_helper"

RSpec.describe "merchant item edit page" do
  before :each do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
  end

  # US8
  it "has a form to update this item, filled in with existing info" do
    visit edit_merchant_item_path(@merchant_1, @item_1)

    within("#update_item_form") do
      expect(page).to have_field(:name)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_field(:description)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_field(:unit_price)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_button("Update Item")
    end
  end

  # US8
  it "updates the item, redirects to merchant item show page, and shows a flash message" do
    visit edit_merchant_item_path(@merchant_1, @item_1)

    within("#update_item_form") do
      fill_in :name, with: "Fantastic Fidget"
      fill_in :description, with: "a fantastically fun fidget!"
      fill_in :unit_price, with: 12345
    end

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))

  end

  # US8
  it "does not submit when info is not entered" do
    visit edit_merchant_item_path(@merchant_1, @item_1)

    within("#update_item_form") do
      fill_in :name, with: ""
      fill_in :description, with: "a fantastically fun fidget!"
      fill_in :unit_price, with: 12345
    end

    expect(page).to have_content("Error: Name can't be blank")
    expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
  end
end