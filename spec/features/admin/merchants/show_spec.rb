require 'rails_helper'

RSpec.describe "Admin Merchant Show Page", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  # US 26
  it "displays a link to update merchant information" do
    visit admin_merchant_path(@merchant1.id)

    expect(page).to have_content("#{@merchant1.name} Show Page")
    expect(page).to have_link("Update Merchant")
    click_link("Update Merchant")

    expect(current_path).to eq(edit_admin_merchant_path(@merchant1.id))

    fill_in "Name", with: "Merchant 2.0"
    click_on "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant1.id))
    expect(page).to have_content("Merchant 2.0 Show Page")
    expect(page).to have_content("Merchant Successfully Updated")
  end
end
