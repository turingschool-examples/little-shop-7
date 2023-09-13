require "rails_helper"

RSpec.describe "Admin Merchants Show Page", type: :feature do
  describe "When i click on the name of a merchant from the admin merchant index page" do
    it "I am taken to the admin merchant show page and i see the name of that merchant" do
      brown_inc = Merchant.create!(name: "Brown Inc")
      quitzon_and_sons = Merchant.create!(name: "Quitzon and Sons")

      visit "/admin/merchants/#{brown_inc.id}"

      expect(page).to have_content(brown_inc.name)
      expect(page).to_not have_content(quitzon_and_sons.name)
    end
  end
end
