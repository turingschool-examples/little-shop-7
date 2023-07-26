require "rails_helper"

RSpec.describe "admin merchants index page" do

  let!(:little_kin_shop) { create(:merchant) }
  let!(:red_roses) { create(:merchant) }
  let!(:halloween_face) { create(:merchant) }
  let!(:tall_boy) { create(:merchant, status: 1) }
  let!(:arleen) { create(:merchant, status: 1) }
  let!(:bust_it_big) { create(:merchant, status: 1) }


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

  


end