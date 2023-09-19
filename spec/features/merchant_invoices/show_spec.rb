require "rails_helper"

RSpec.describe "the merhcant invoices show page" do
    it "I see information related to that invoice including: id, status, created_at date, and customer first and last name" do
      @merchant_1 = create(:merchant)
      @customer_1 = create(:customer)
            
      @item_1 = create(:item, merchant_id: @merchant_1.id) 
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)   
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("ID: #{@invoice_1.id}")
      expect(page).to have_content("STATUS: #{@invoice_1.status}")
      expect(page).to have_content("CREATED AT: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("CUSTOMER NAME: #{@customer_1.first_name} #{@customer_1.last_name}")
    end

    it "displays each item belonging to that specific merchant in the invoice" do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
  
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_2.id)
      @item_3 = create(:item, merchant_id: @merchant_1.id)
  

      @invoice_1 = create(:invoice, customer_id: @customer_1.id)

      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id)
      @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
      

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content()
    end
  end

#   Merchant Invoice Show Page: Invoice Item Information
# As a merchant
# When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
# Then I see all of my items on the invoice including:

# Item name
# The quantity of the item ordered
# The price the Item sold for
# The Invoice Item status
# And I do not see any information related to Items for other merchants