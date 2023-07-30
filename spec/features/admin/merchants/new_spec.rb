require "rails_helper"

RSpec.describe "admin merchants new page" do

  let!(:little_kin_shop) { create(:merchant, name: "Dave Schools", status: 0) }
  let!(:red_roses) { create(:merchant, name: "Sunny", status: 0) }
  let!(:halloween_face) { create(:merchant, name: "JB", status: 0) }
  let!(:tall_boy) { create(:merchant) }
  let!(:arleen) { create(:merchant) }
  let!(:bust_it_big) { create(:merchant) }

  before do
    visit new_admin_merchant_path
  end

  it "provides a form for creating new merchant" do
    expect(page).to have_content("New Merchant")
    expect(page).to have_field("Name")
    expect(page).to have_content("Name")
  end

  it "redirects to admin merchants index page after filling out form and displays newly added merchant" do
    fill_in "Name", with: "Tackle Box Hero"

    click_button "Create Merchant"
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Tackle Box Hero")
    expect(Merchant.last.name).to eq("Tackle Box Hero")
  end


end