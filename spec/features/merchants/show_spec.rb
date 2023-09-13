require "rails_helper"

RSpec.describe "Merchant Dashboard show page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: "Ray's Handmade Jewelry")
  end

  it "displays the name of the merchant" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
save_and_open_page
    expect(page).to have_content(@merchant_1.name)
  end
end