require "rails_helper"

RSpec.describe "Invoices show page", type: :feature do
  describe "As an admin, When I visit an admin invoice show page (/admin/invoices/:invoice_id)" do
    # Story 34
    it "Then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at date in the format 'Monday, July 18, 2019', Customer first and last name" do
      test_data
      visit invoice_path(@invoice_1.id)

      within("#invoice_info") do
        expect(page).to have_content("#{@invoice_1.id}")
        expect(page).to have_content("#{@invoice_1.status}")
        expect(page).to have_content("#{@invoice_1.created_at.strftime('%A, %B %d, %Y')}")
        expect(page).to have_content("#{@invoice_1.customer.first_name}")
        expect(page).to have_content("#{@invoice_1.customer.last_name}")
      end
    end

    # Story 34
    it "Then I see all of the items on the invoice including: Item name, The quantity of the item ordered, The price the Item sold for, The Invoice Item status" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, status: "in progress", customer: customer)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1, status: 0)
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2, status: 0)
      invoice_item_3 = create(:invoice_item, invoice: invoice, item: item_3, status: 0)

      visit invoice_path(invoice.id)
      
      within("#item#{item_1.id}") do
        expect(page).to have_content("#{item_1.name}")
        expect(page).to have_content("#{invoice_item_1.quantity}")
        expect(page).to have_content("#{invoice_item_1.unit_price}")
      end
      within("#item#{item_2.id}") do
        expect(page).to have_content("#{item_2.name}")
        expect(page).to have_content("#{invoice_item_2.quantity}")
        expect(page).to have_content("#{invoice_item_2.unit_price}")
      end
      within("#item#{item_3.id}") do
        expect(page).to have_content("#{item_3.name}")
        expect(page).to have_content("#{invoice_item_3.quantity}")
        expect(page).to have_content("#{invoice_item_3.unit_price}")
      end

      # Story 35
      total_revenue = (invoice_item_1.quantity * invoice_item_1.unit_price)+(invoice_item_2.quantity * invoice_item_2.unit_price)+(invoice_item_3.quantity * invoice_item_3.unit_price)
      expect(page).to have_content("Total Revenue: $#{total_revenue}")
    end
  end
end