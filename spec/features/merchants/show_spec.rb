require "rails_helper"

RSpec.describe "the merchant show" do
  it "shows the merchants name" do
    merchant = Merchant.create(name: "Bob Burger")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end
end
