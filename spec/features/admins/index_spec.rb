require "rails_helper"

RSpec.describe "Merchants Index Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "John")
    @merchant_2 = Merchant.create!(name: "Jacob")
    @merchant_3 = Merchant.create!(name: "Jingleheimer")
    @merchant_4 = Merchant.create!(name: "Schmidt")
    @merchant_5 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_6 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_7 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_8 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_9 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_10 = Merchant.create!(name: Faker::Name.first_name)
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

  describe "User Story 27" do
    it "has a button to enable or disable every Merchant next to their name" do
      visit admin_merchants_path

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("Enable Merchant")
        expect(page).to have_no_button("Disable Merchant")
        click_button("Enable Merchant")
        expect(page).to have_button("Disable Merchant")
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button("Enable Merchant")
      end

      within "#merchant-#{@merchant_3.id}" do
        expect(page).to have_button("Enable Merchant")
      end

      within "#merchant-#{@merchant_4.id}" do
        expect(page).to have_button("Enable Merchant")
        expect(page).to have_no_button("Disable Merchant")
        click_button ("Enable Merchant")
        expect(page).to have_button("Disable Merchant")
      end
    end
  end

  describe "User Story 28" do
    it "has separate sections for Enabled Merchants and Disabled Merchants" do
      merchant_11 = Merchant.create!(name: "Jack", status: "enabled")
      merchant_12 = Merchant.create!(name: "Jill", status: "enabled")

      visit admin_merchants_path

      within "#enabled-merchants" do
        expect(page).to have_content("Jack")
        expect(page).to have_content("Jill")
      end

      within "#disabled-merchants" do
        expect(page).to have_content("John")
        expect(page).to have_content("Jacob")
        expect(page).to have_content("Jingleheimer")
      end
    end
  end
end
