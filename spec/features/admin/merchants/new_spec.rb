require "rails_helper"

RSpec.describe "Admin::Merchant new page" do
  #US 29
  it "can be found from the admin merchants index" do
    visit admin_merchants_path
    click_link("create a new merchant")
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "contains a form to create a new merchant" do 
    visit new_admin_merchant_path
    expect(page).to have_field(:name)
    expect(page).to have_button("Add Merchant")
    fill_in :name, with:"Blaine's Vapes"
    click_button("Add Merchant")
    expect(current_path).to eq(admin_merchants_path)
    within("#disabled-merchants") do
      expect(page).to have_content("Blaine's Vapes")
    end
  end
end