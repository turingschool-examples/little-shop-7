require "rails_helper"

RSpec.describe "Merchant Dashboard" do 
  describe "It shows the merchant dashboard" do
    it "shows the name of the merchant in the merchant dashboard" do
      merchant = Merchant.create!(id: 1, name: "Dealer of Death", status: 1)
      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content("Dealer of Death")
    end

    it "has links to invoices index" do 
      merchant = Merchant.create!(id: 1, name: "Dealer of Death", status: 1)
      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_link("My Invoices")
      expect(page).to have_link("My Items")
    end
  end
end