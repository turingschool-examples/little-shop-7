require "rails_helper"

RSpec.describe "the merchant dashboard show page" do
  it "shows the merchant's name" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant_lego.name)
  end
end
