require "rails_helper"

RSpec.describe "merchant invoice show page" do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @customer = FactoryBot.create(:customer)
    @invoice = FactoryBot.create(:invoice, customer: @customer)
    @item = FactoryBot.create(:item, merchant: @merchant)
    @invoice_item = FactoryBot.create(:invoice_item, item: @item, invoice: @invoice)

    @merchant_2 = FactoryBot.create(:merchant)
    @customer_2 = FactoryBot.create(:customer)
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer_2)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_2)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2)
  end

  describe "as a merchant" do
    describe "when I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)" do
      # User Story 15
      it "then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at in the format 'Monday, July 18, 2019', customer first and last name" do
        visit merchant_invoice_path(@merchant, @invoice)

        expect(page).to have_content(@invoice.id)
        expect(page).to have_content(@invoice.status)
        expect(page).to have_content(@invoice.format_created_at) 
        expect(page).to have_content(@customer.first_name)
        expect(page).to have_content(@customer.last_name)
      end

      # User Story 16
      it "then I see all of my items on the invoice including: Item name, the quantity of the item ordered, the price the Item sold for, the Invoice Item status, and I do not see any information related to Items for other merchants" do
        visit merchant_invoice_path(@merchant, @invoice)

        expect(page).to have_content(@item.name)
        expect(page).to have_content(@invoice_item.quantity)
        expect(page).to have_content(@invoice_item.format_selling_price) 
        expect(page).to have_content(@invoice_item.status)

        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@invoice_item_2.format_selling_price)
        expect(page).to_not have_content(@invoice_item_2.status)
      end
    end
  end
end