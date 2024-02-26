require 'rails_helper'

RSpec.describe 'Admin Index Show', type: :feature do
  describe 'As an Admin' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_7 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_8 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_9 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")

      @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_2 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_3 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_4 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_5 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_6 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_7 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_8 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_9 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_10 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_11 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_12 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_13 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_14 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_15 = create(:transaction, invoice_id: @invoice_5.id)
      @trans_16 = create(:transaction, invoice_id: @invoice_6.id)
      @trans_17 = create(:transaction, invoice_id: @invoice_6.id, result: 1)
      @trans_18 = create(:transaction, invoice_id: @invoice_7.id)
      @trans_19 = create(:transaction, invoice_id: @invoice_8.id)
      @trans_20 = create(:transaction, invoice_id: @invoice_9.id, result: 1)
      
      @merchant_1 = create(:merchant, name: "Amazon", status: 0) 
      @merchant_2 = create(:merchant, name: "Walmart", status: 0) 
      @merchant_3 = create(:merchant, name: "Apple", status: 0) 
      @merchant_4 = create(:merchant, name: "Microsoft", status: 0) 
      @merchant_5 = create(:merchant, name: "Petco", status: 1) 
      @merchant_6 = create(:merchant, name: "Aetna", status: 1) 
      @merchant_7 = create(:merchant, name: "Adidas", status: 1) 

      @item_1 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_3 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_4 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_5 = create(:item, unit_price: 1, merchant_id: @merchant_2.id)
      @item_6 = create(:item, unit_price: 1, merchant_id: @merchant_2.id)
      @item_7 = create(:item, unit_price: 1, merchant_id: @merchant_3.id)
      @item_8 = create(:item, unit_price: 1, merchant_id: @merchant_4.id)
      @item_9 = create(:item, unit_price: 1, merchant_id: @merchant_5.id)
      @item_10 = create(:item, unit_price: 1, merchant_id: @merchant_6.id)

      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_3 = create(:invoice_item, item_id: @item_9.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 500, status: 1)
      @invoice_item_4 = create(:invoice_item, item_id: @item_10.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 100, status: 2)
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 78000, status: 2)
      @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: 78000, status: 0)
      @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: 78000, status: 0)
      @invoice_item_8 = create(:invoice_item, item_id: @item_8.id, invoice_id: @invoice_9.id, quantity: 4, unit_price: 5500, status: 0)
      @invoice_item_9 = create(:invoice_item, item_id: @item_8.id, invoice_id: @invoice_1.id, quantity: 4, unit_price: 5500, status: 2)
    end

    # User story 33. Admin Invoice Show Page
    it 'displays all information about that invoice, including the customer first and last name' do
      # As an admin, when I visit an admin invoice show page (/admin/invoices/:invoice_id)
      visit admin_invoice_path(@invoice_1.id)
      # Then I see information related to that invoice including:
      # Invoice id
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      # Invoice status
      expect(page).to have_content("Status: #{@invoice_1.status}")
      # Invoice created_at date in the format "Monday, July 18, 2019"
      expect(page).to have_content("Created on: Wednesday, February 21, 2024")
      # Customer first and last name
      expect(page).to have_content("Customer: #{@customer_1.first_name} #{@customer_1.last_name}")
    end

    # User Story 34. Admin Invoice Show Page: Invoice Item Information
    it "displays all of the items on the invoice, with name, quantity and price, and Invoice item status" do
      # As an admin, When I visit an admin invoice show page (/admin/invoices/:invoice_id)
      visit admin_invoice_path(@invoice_1.id)
      # Then I see all of the items on the invoice including:
      expect(page).to have_content("Items on this invoice")
      within "#invoice_item-#{@invoice_item_1.id}" do
        # Item name
        expect(page).to have_content(@item_1.name)
        # The quantity of the item ordered
        expect(page).to have_content(@invoice_item_1.quantity)
        # The price the Item sold for
        expect(page).to have_content(@invoice_item_1.unit_price)
        # The Invoice Item status
        expect(page).to have_content(@invoice_item_1.status)
      end

      within "#invoice_item-#{@invoice_item_9.id}" do
        # Item name
        expect(page).to have_content(@item_8.name)
        # The quantity of the item ordered
        expect(page).to have_content(@invoice_item_9.quantity)
        # The price the Item sold for
        expect(page).to have_content(@invoice_item_9.unit_price)
        # The Invoice Item status
        expect(page).to have_content(@invoice_item_9.status)
      end
    end
  end
end