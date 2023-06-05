require "rails_helper"

RSpec.describe "Merchant Invoices Show Page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer2.id)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_5.id)
  end
  describe "As a merchant" do
    it "displays information for a single invoice" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      within("#invoice_info") do
        expect(page).to have_content("Invoice #{@invoice_1.id}")
        expect(page).to have_content("Status: #{@invoice_1.status}")
        expect(page).to have_content("Created on: #{@invoice_1.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Customer: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
      end
    end
  end
end