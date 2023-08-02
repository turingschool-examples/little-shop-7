require "rails_helper"

RSpec.describe "logo partial" do
  it "displays the logo on merchant show page and shows number of likes" do
    merchant = create(:merchant)
    
    visit merchant_path(merchant)

    within ".logo" do
      expect(page).to have_css("img[src]")
    end

    within ".logo_likes" do 
      expect(page).to have_content("Number of Likes: 449")
    end
  end

  it "displays the logo on merchant index page" do
    merchant = create(:merchant)

    visit merchants_path(merchant, merchant_id: merchant.id)

    within ".logo" do
      expect(page).to have_css("img[src]")
    end
  end
end