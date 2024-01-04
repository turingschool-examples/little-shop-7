require "rails_helper"

RSpec.describe "Merchants Index Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "John")
    @merchant_2 = Merchant.create!(name: "Jacob")
    @merchant_3 = Merchant.create!(name: "Jingleheimer")
    @merchant_4 = Merchant.create!(name: "Schmidt")
    @merchant_5 = Merchant.create!(name: Faker::Name)
    @merchant_6 = Merchant.create!(name: Faker::Name)
    @merchant_7 = Merchant.create!(name: Faker::Name)
    @merchant_8 = Merchant.create!(name: Faker::Name)
    @merchant_9 = Merchant.create!(name: Faker::Name)
    @merchant_10 = Merchant.create!(name: Faker::Name)
  end

  describe "User Story 24" do
    it "displays the name of each merchant in the system" do
      visit admin_merchants_path
      
      expect(page).to have_content("John")
      expect(page).to have_content("Jacob")
      expect(page).to have_content("Jingleheimer")
      expect(page).to have_content("Schmidt")
    end
  end
end
