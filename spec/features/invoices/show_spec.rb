require "rails_helper"

RSpec.describe "the merchant invoices show page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_2.id)

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)

    @invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 100, status: "packaged")
    @invoice_item_2 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 100, status: "packaged")
  end

  describe "User Story 15" do
    # As a merchant
    # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see information related to that invoice including:

    # Invoice id
    # Invoice status
    # Invoice created_at date in the format "Monday, July 18, 2019"
    # Customer first and last name
    
    it "displays information about a given invoice" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status.titleize}")
      expect(page).to have_content("Created on: #{@invoice_1.format_created_date}")
      expect(page).to have_content("Customer: #{@invoice_1.customer.full_name}")
    end
  end

  describe "User Story 16" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see all of my items on the invoice including:

    # Item name
    # The quantity of the item ordered
    # The price the Item sold for
    # The Invoice Item status
    # And I do not see any information related to Items for other merchants

    xit "displays a table of items" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Items on this Invoice:")
      # expect(page).to have_css('table')
      expect(page).to have_content("Item Name")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("Unit Price")
      expect(page).to have_content("Status")
    end

    it "displays the correct items in the table based on the merchant who is viewing" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.quantity)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_content(@item_1.status)
      expect(page).to_not have_content(@item_2.name) # should not see item 2 because item 2 does not belong to merchant 1

      # Visit the same invoice page, but view as a different merchant
      visit "/merchants/#{@merchant_2.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.quantity)
      expect(page).to have_content(@item_2.unit_price)
      expect(page).to have_content(@item_2.status)
      expect(page).to_not have_content(@item_1.name) # should not see item 1 because item 1 does not belong to merchant 2
    end
  end
end