require "rails_helper"

RSpec.describe "admin merchants index page" do

  let!(:little_kin_shop) { create(:merchant, name: "Dave Schools", status: 0) }
  let!(:red_roses) { create(:merchant, name: "Sunny", status: 0) }
  let!(:halloween_face) { create(:merchant, name: "JB", status: 0) }
  let!(:tall_boy) { create(:merchant) }
  let!(:arleen) { create(:merchant) }
  let!(:bust_it_big) { create(:merchant) }

  before do
    visit admin_merchants_path
  end

  it "displays all enabled merchants" do
    within(".enabled_merchants") do
      expect(page).to have_content(little_kin_shop.name)
      expect(page).to have_content(red_roses.name)
      expect(page).to have_content(halloween_face.name)
      expect(page).to_not have_content(tall_boy.name)
      expect(page).to_not have_content(arleen.name)
      expect(page).to_not have_content(bust_it_big.name)
    end
  end

  it "displays all disabled merchants" do
    within(".disabled_merchants") do
      expect(page).to_not have_content(little_kin_shop.name)
      expect(page).to_not have_content(red_roses.name)
      expect(page).to_not have_content(halloween_face.name)
      expect(page).to have_content(tall_boy.name)
      expect(page).to have_content(arleen.name)
      expect(page).to have_content(bust_it_big.name)
    end
  end

  it "provides link to a merchant's show page" do
    click_link little_kin_shop.name
    expect(current_path).to eq(admin_merchant_path(little_kin_shop))
  end

  it "provides button to disable merchant from index page" do
    within(".merchant-#{little_kin_shop.id}") do
      expect(page).to have_button("Disable")
      click_button "Disable"
      expect(current_path).to eq(admin_merchants_path)
    end
    within(".disabled_merchants") do
      expect(page).to have_content(little_kin_shop.name)
    end
  end

  it "provides button to enable merchant from index page" do
    within(".merchant-#{tall_boy.id}") do
      expect(page).to have_button("Enable")
      click_button "Enable"
      expect(current_path).to eq(admin_merchants_path)
    end
    within(".enabled_merchants") do
      expect(page).to have_content(little_kin_shop.name)
    end
  end

  it "provides link to a form for creating a new merchant" do
    within(".new_merchant") do
      expect(page).to have_link("New Merchant")
      click_link "New Merchant"
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end
end