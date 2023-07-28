require "rails_helper"

RSpec.describe "merchant invoices index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @items = create_list(:item, 20, merchant: @merchant_1)

    # Create invoices and associate with items
    @invoices = create_list(:invoice, 20)
    @invoice_items = @invoices.map do |invoice|
      create(:invoice_item, item: @items.sample, invoice: invoice)
    end
  end

  describe "as a merchant" do
    describe "when I visit my merchant's invoices index (/merchants/:merchant_id/invoices)" do
      it "Then I see all of the invoices that include at least one of my merchant's items, and for each invoice I see its id" do
        visit merchant_invoices_path(@merchant_1)

        expect(page).to have_content("My Invoices")

        invoice_id = @invoice_items.map do |invoice_item|
          invoice_item.invoice_id
          expect(page).to have_content("Invoice " + "#" + "#{invoice_id}")
        end
      end

      it "and each id links to the merchant invoice show page" do
        customer_1 = FactoryBot.create(:customer)
        invoice_1 = FactoryBot.create(:invoice, customer: customer_1)
        item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      
        invoice_item_1 = FactoryBot.create(:invoice_item, item: item_1, invoice: invoice_1)
      
        visit merchant_invoices_path(@merchant_1)
        expect(page).to have_link(invoice_item_1.id)
      
        click_link invoice_item_1.id
      
        expect(current_path).to eq(merchant_invoice_path(@merchant_1, invoice_item_1.invoice_id))
      end
    end
  end
end