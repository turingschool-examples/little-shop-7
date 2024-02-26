require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page' do
  let(:merchant) { FactoryBot.create(:merchant) }

  let(:item_1) { FactoryBot.create(:item, merchant: merchant) }
  let(:item_2) { FactoryBot.create(:item, merchant: merchant) }
  let(:item_3) { FactoryBot.create(:item, merchant: merchant) }

  let(:customer) { FactoryBot.create(:customer) }

  let(:invoice_1) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 3.day) }
  let(:invoice_2) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 2.day) }
  let(:invoice_3) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 5.day) }

  let!(:invoice_item_1) { InvoiceItem.create!(invoice: invoice_1, item: item_1, status: "packaged") }
  let!(:invoice_item_2) { InvoiceItem.create!(invoice: invoice_2, item: item_2, status: "packaged") }
  let!(:invoice_item_3) { InvoiceItem.create!(invoice: invoice_3, item: item_3, status: "shipped") }

  describe "As a merchant" do
    describe "User Story 14" do
      it "shows all the invoices of the merchant and each id links to its invoice show page" do
        visit merchant_invoices_path(merchant_id: merchant.id)

        expect(page).to have_link("Invoice ##{invoice_1.id}", href: merchant_invoice_path(merchant, invoice_1))
        expect(page).to have_link("Invoice ##{invoice_2.id}", href: merchant_invoice_path(merchant, invoice_2))
        expect(page).to have_link("Invoice ##{invoice_3.id}", href: merchant_invoice_path(merchant, invoice_3))
      end
    end
  end
end
