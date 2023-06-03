require "rails_helper"

RSpec.describe "/merchants/:id/dashboard" do
  describe "As a visitor" do
    describe "when I visit a merchants show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_2) { create(:item, merchant_id: merchant_1.id) }

      # User Story 1

      it "directs me to the merchants dashboard where I see the merchants name" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit "/merchants/#{merchant_2.id}/dashboard"
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end

      # 2. Merchant Dashboard Links

      it "links to the merchants items index" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        expect(page).to have_content("#{merchant_1.name} Items")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/items")
        expect(page).to have_content("#{merchant_2.name} Items")
      end

      it "links to the merchants invoices index"do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
        expect(page).to have_content("#{merchant_1.name} Invoices")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/invoices")
        expect(page).to have_content("#{merchant_2.name} Invoices")
      end

    end
  end
end