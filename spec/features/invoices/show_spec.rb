require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  let(:merchant) { FactoryBot.create(:merchant) }
  let(:item) { FactoryBot.create(:item, merchant: merchant) }
  let(:customer) { FactoryBot.create(:customer) }
  let(:invoice) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current) }
  let!(:invoice_item) { InvoiceItem.create!(invoice: invoice, item: item, status: "packaged") }

  describe "As a merchant" do
    describe "User Story 15" do
      it "shows information related to the invoice" do
        visit merchant_invoice_path(merchant_id: merchant.id, id: invoice.id)
        save_and_open_page

        expect(page).to have_content(invoice.id)
        expect(page).to have_content(invoice.status)
        expect(page).to have_content(invoice.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(customer.first_name)
        expect(page).to have_content(customer.last_name)
      end
    end
  end
end
