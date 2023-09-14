require "rails_helper"

RSpec.describe "Admin Merchants Index Page", type: :feature do
  describe "empty merchant index page" do
    xit "can display a message when there are no merchants" do

      visit "/admin/merchants"

      expect(page).to have_content("No Merchants Found")
    end
  end

  describe "complete merchant list" do
    xit "can list all merchants" do
      brown_inc = Merchant.create!(name: "Brown Inc")
      quitzon_and_sons = Merchant.create!(name: "Quitzon and Sons")
      boehm_llc = Merchant.create!(name: "Boehm LLC")

      visit "/admin/merchants"

      expect(page).to have_content(brown_inc.name)
      expect(page).to have_content(quitzon_and_sons.name)
      expect(page).to have_content(boehm_llc.name)
    end
  end

  describe "merchant list has button to disable merchant" do
    it "when clicked can disable a merchant" do
      @brown_inc = Merchant.create!(name: "Brown Inc")

      visit "/admin/merchants"

      expect(page).to have_content(@brown_inc.name)
      within("#merchant-#{@brown_inc.name}") do
        click_button "Disable"
      end

      expect(page).to have_content("Merchant #{@brown_inc.name} disabled.")
      expect(page).to have_button("Enable")
    end
  end
end