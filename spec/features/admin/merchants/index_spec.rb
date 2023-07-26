require "rails_helper"

RSpec.describe "admin merchants index page" do

  let!(:little_kin_shop) { create(:merchant) }
  let!(:red_roses) { create(:merchant) }
  let!(:halloween_face) { create(:merchant) }

  
  before do
    visit admin_merchants_path
  end

  it "displays all merchants" do
    within(".all_merchants") do
      expect(page).to have_content(little_kin_shop.name)
      expect(page).to have_content(red_roses.name)
      expect(page).to have_content(halloween_face.name)
    end
  end


end