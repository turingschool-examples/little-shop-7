require "rails_helper"

RSpec.describe "Admin Merchant Page", type: :feature do
  describe "When I visit the merchant index (/admin/merchants)" do
    # US 24
    it "I a list of all the merchants" do
      merchant_1 = Merchant.create!(name: "Bob's Burgers")
      visit admin_merchants_path

      expect(page).to have_content("Bob's Burgers")
    end
  end

  describe "When I visit the merchant index (/admin/merchants)" do
  # US 25
  it "I can click on a merchant name and be taken to the merchant show page" do
    merchant_1 = Merchant.create!(name: "Bob's Burgers")
    merchant_2 = Merchant.create!(name: "Kwik-E-Mart")
    visit admin_merchants_path
    expect(page).to have_link("Bob's Burgers")

    click_link("Bob's Burgers")
    expect(current_path).to eq(admin_merchant_path(merchant_1))
    end
  end
end
