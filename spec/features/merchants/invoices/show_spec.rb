require "rails_helper"

RSpec.describe "Merchant invoice show" do
  describe "US15 & 16" do
              #     As a merchant
              # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
              # Then I see information related to that invoice including:
              # - Invoice id
              # - Invoice status
              # - Invoice created_at date in the format "Monday, July 18, 2019"
              # - Customer first and last name
    before :each do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      
      @item = create(:item, merchant:@merchant)
      @item2 = create(:item, merchant:@merchant)
      @item3 = create(:item, merchant:@merchant, unit_price: 899)
      @item4 = create(:item, merchant:@merchant2)
      @item5 = create(:item, merchant:@merchant2)
    
      @customer = create(:customer)

      @invoice = create(:invoice, customer: @customer)
      
      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice, status: 0)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice, status: 0)
      @invoice_item3 = create(:invoice_item, item: @item3, invoice: @invoice, status: 0)
      
    end
    it "Visits merchants invoice show page" do
      visit merchant_invoice_path(@merchant, @invoice.id)
      
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end

    describe "User Story 16" do
            # - Item name
            # - The quantity of the item ordered
            # - The price the Item sold for
            # - The Invoice Item status
            # And I do not see any information related to Items for other merchants
      it "Shows all the items attached to an invoice" do
        visit merchant_invoice_path(@merchant, @invoice.id)


        expect(page).to have_content(@item.name)
        expect(page).to have_content(@invoice_item.quantity)
        expect(page).to have_content("$8.99")
        expect(page).to have_content(@invoice_item3.status)
        expect(page).to_not have_content(@item5.name)
      end
    end
  end
end