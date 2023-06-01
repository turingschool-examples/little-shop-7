require 'rails_helper'

RSpec.describe "Admin Merchant Index Page", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Fred")
  end

  describe "When I visit the admin merchants index" do
    it "displays the name of each merchant in the system" do
      visit "admin/merchants"

      expect(page).to have_content("Admin Merchant Index Page")
      expect(page).to have_content("Merchants:")
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end
end