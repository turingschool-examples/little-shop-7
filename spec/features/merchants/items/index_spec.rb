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

  it "has buttons to enable or disable for each item" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_button("Enabled")
    expect(page).to have_button("Disable Item")
  end

  it "enable button changes item status and redirects back" do
    visit merchant_items_path(@merchant_1)

    within("##{@item_1.id}") do
      click_button "Enable Item"
    end

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    within("##{@item_1.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to have_button("Disable Item")
    end
  end

  it "disable button changes item status and redirects back" do
    visit merchant_items_path(@merchant_1)

    within("##{@item_1.id}") do
      click_button "Disable Item"
    end

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    within("##{@item_1.id}") do
      expect(page).to have_content("Disabled")
      expect(page).to have_button("Enable Item")
    end
  end
end