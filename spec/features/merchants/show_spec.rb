require "rails_helper"

RSpec.describe "Merchant Show Page" do
  describe "Dashboard" do
  #User Story 1
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant
    it "Displays the name of the merchant" do
      @merchant_1 = Merchant.create(name: "Steve")
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content(@merchant_1.name)
      save_and_open_page
    end
  end
end