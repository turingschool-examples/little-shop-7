require "rails_helper"

RSpec.describe "Dashboard" do
  before :each do
    @merchant1 = Merchant.create!(name: "Billy")
    @merchant2 = Merchant.create!(name: "Nathan")
  end
  it "shows the name of the merchant" do
  # 1. Merchant Dashboard
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see the name of my merchant
  visit "/merchants/#{@merchant1.id}/dashboard"
  expect(page).to have_content(@merchant1.name)
  expect(page).to_not have_content(@merchant2.name)
  end
end