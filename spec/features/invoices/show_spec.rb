require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  describe "As a merchant" do
    let(:merchant) { FactoryBot.create(:merchant) }

    let(:item_1) { FactoryBot.create(:item, merchant: merchant) }
    let(:item_2) { FactoryBot.create(:item, merchant: merchant) }
    let(:item_3) { FactoryBot.create(:item, merchant: merchant) }

    let(:customer) { FactoryBot.create(:customer) }

    let(:invoice) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current) }

    let!(:invoice_item_1) { InvoiceItem.create!(invoice: invoice, quantity: 2, unit_price: 20, item: item_1, status: "packaged") }
    let!(:invoice_item_2) { InvoiceItem.create!(invoice: invoice, quantity: 1, unit_price: 10, item: item_2, status: "shipped") }
    let!(:invoice_item_3) { InvoiceItem.create!(invoice: invoice, quantity: 5, unit_price: 7, item: item_3, status: "pending") }

    describe "User Story 15" do
      it "shows information related to the invoice" do
        visit merchant_invoice_path(merchant_id: merchant.id, id: invoice.id)

        expect(page).to have_content(invoice.id)
        expect(page).to have_content(invoice.status)
        expect(page).to have_content(invoice.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(customer.first_name)
        expect(page).to have_content(customer.last_name)
      end
    end

    describe "User Story 16" do
      it "shows all of the items on the invoice with the items' information" do
        visit merchant_invoice_path(merchant_id: merchant.id, id: invoice.id)

        expect(page).to have_content(item_1.name)
        expect(page).to have_content(invoice_item_1.quantity)
        expect(page).to have_content(invoice_item_1.unit_price)
        expect(page).to have_content(invoice_item_1.status)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(invoice_item_2.quantity)
        expect(page).to have_content(invoice_item_2.unit_price)
        expect(page).to have_content(invoice_item_2.status)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(invoice_item_3.quantity)
        expect(page).to have_content(invoice_item_3.unit_price)
        expect(page).to have_content(invoice_item_3.status)
      end
    end
  end
end