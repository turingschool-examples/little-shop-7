require "rails_helper"

RSpec.describe "merchant invoice show page" do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @customer = FactoryBot.create(:customer)
    @invoice = FactoryBot.create(:invoice, customer: @customer)
    @item = FactoryBot.create(:item, merchant: @merchant)
    @invoice_item = FactoryBot.create(:invoice_item, item: @item, invoice: @invoice)
  end

  describe "as a merchant" do
    describe "when I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)" do
      it "then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at in the format 'Monday, July 18, 2019', customer first and last name" do
        visit merchant_invoice_path(@merchant, @invoice)

        expect(page).to have_content(@invoice.id)
        expect(page).to have_content(@invoice.status)
        expect(page).to have_content(@invoice.format_created_at) #formatted
        expect(page).to have_content(@customer.first_name)
        expect(page).to have_content(@customer.last_name)
      end
    end
  end
end