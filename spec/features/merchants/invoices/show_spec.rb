require 'rails_helper'

RSpec.describe 'merchant invoices index page (/merchants/:merchant_id/invoices)' do
  before :each do
    test_data_2
    @invoices = [@invoice1, @invoice2, @invoice3]
  end
  describe 'when I visit /merchants/:merchant_id/invoices' do
    it 'shows all the invoices that include at least on of my merchant items' do
      # 15. Merchant Invoice Show Page
      # As a merchant
      # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
      # Then I see information related to that invoice including:
      # - Invoice id
      # - Invoice status
      # - Invoice created_at date in the format "Monday, July 18, 2019"
      # - Customer first and last name
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice1.status)
        expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(@invoice1.customer.name)
      end
      it "shows item and invoice_item information on the invoice" do
        # 16. Merchant Invoice Show Page: Invoice Item Information
        # As a merchant
        # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
        # Then I see all of my items on the invoice including:
        # - Item name
        # - The quantity of the item ordered
        # - The price the Item sold for
        # - The Invoice Item status
        # And I do not see any information related to Items for other merchants
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
        expect(page).to have_content(@item4.name)
        expect(page).to have_content(@item6.name)
        expect(page).to have_content(@item7.name)
        expect(page).to have_content(@item8.name)

        expect(page).to have_content(@item1.unit_price)
        expect(page).to have_content(@item2.unit_price)
        expect(page).to have_content(@item3.unit_price)
        expect(page).to have_content(@item4.unit_price)
        expect(page).to have_content(@item6.unit_price)
        expect(page).to have_content(@item7.unit_price)
        expect(page).to have_content(@item8.unit_price)


        expect(page).to have_content(@invoice_item1.status)
        expect(page).to have_content(@invoice_item2.status)
        expect(page).to have_content(@invoice_item3.status)
        expect(page).to have_content(@invoice_item4.status)
        expect(page).to have_content(@invoice_item6.status)
        expect(page).to have_content(@invoice_item7.status)
        expect(page).to have_content(@invoice_item8.status)

        expect(page).to have_content(@invoice_item1.quantity)
        expect(page).to have_content(@invoice_item2.quantity)
        expect(page).to have_content(@invoice_item3.quantity)
        expect(page).to have_content(@invoice_item4.quantity)
        expect(page).to have_content(@invoice_item6.quantity)
        expect(page).to have_content(@invoice_item7.quantity)
        expect(page).to have_content(@invoice_item8.quantity)
      end
      it "shows total revenue" do
        # 17. Merchant Invoice Show Page: Total Revenue
        # As a merchant
        # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
        # Then I see the total revenue that will be generated from all of my items on the invoice
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
        save_and_open_page
        expect(page).to have_content("Total Revenue")
        expect(page).to have_content("$41,417.00")
      end
    end
  end