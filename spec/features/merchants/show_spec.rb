require "rails_helper"

RSpec.describe "/merchants/:id/dashboard" do
  describe "As a visitor" do
    describe "when I visit a merchants show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_2) { create(:item, merchant_id: merchant_2.id) }

      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0)}
      let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 1)}

      let!(:invoice_item_1) { create(:invoice_item, unit_price: 1000, invoice_id: invoice_1.id, item_id: item_1.id) }

      let!(:customer_1) { create(:customer) }
      let!(:customer_2) { create(:customer) }

      # User Story 1

      xit "directs me to the merchants dashboard where I see the merchants name" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit "/merchants/#{merchant_2.id}/dashboard"
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end

      # 2. Merchant Dashboard Links

      xit "links to the merchants items index" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        expect(page).to have_content("#{merchant_1.name} Items")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/items")
        expect(page).to have_content("#{merchant_2.name} Items")
      end

      xit "links to the merchants invoices index" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
        expect(page).to have_content("#{merchant_1.name} Invoices")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/invoices")
        expect(page).to have_content("#{merchant_2.name} Invoices")
      end
      # 3. Merchant Dashboard Statistics - Favorite Customers

      # As a merchant,
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions with my merchant
      # And next to each customer name I see the number of successful transactions they have
      # conducted with my merchant

      it "see top 5 customers on on dashboard" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        save_and_open_page
        expect(page).to have_content("Top 5 Customers")
        expect(page).to have_content(customer_1.name)
      end
    end
  end
end
