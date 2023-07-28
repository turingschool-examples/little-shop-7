require "rails_helper"

RSpec.describe "admin merchants edit page" do

  let!(:little_kin_shop) { create(:merchant, name: "Dave Schools", status: 0) }
  let!(:red_roses) { create(:merchant, name: "Sunny", status: 0) }
  let!(:halloween_face) { create(:merchant, name: "JB", status: 0) }
  let!(:tall_boy) { create(:merchant) }
  let!(:arleen) { create(:merchant) }
  let!(:bust_it_big) { create(:merchant) }

  before do
    visit edit_admin_merchant_path(little_kin_shop)
  end

  it "provides a form that autopopulates merchant info for editing" do
    expect(page).to have_field("Name", with: "Dave Schools")
    expect(page).to_not have_content("JB")
    fill_in "Name", with: "DAS"
    click_button "Update Merchant"
    expect(current_path).to eq(admin_merchant_path(little_kin_shop))
    expect(page).to have_content("DAS")
    expect(:alert).to be_present
  end
end