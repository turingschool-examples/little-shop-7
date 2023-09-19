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

      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("ITEM NAME: #{@item_1.name}")
      expect(page).to have_content("QUANTITY: #{@invoice_item_1.quantity}")
      expect(page).to have_content("UNIT PRICE: #{@invoice_item_1.unit_price}")
      expect(page).to have_content("ITEM STATUS: #{@invoice_item_1.status}")

      expect(page).to have_content("ITEM NAME: #{@item_3.name}")
      expect(page).to have_content("QUANTITY: #{@invoice_item_3.quantity}")
      expect(page).to have_content("UNIT PRICE: #{@invoice_item_3.unit_price}")
      expect(page).to have_content("ITEM STATUS: #{@invoice_item_3.status}")


      expect(page).not_to have_content("ITEM NAME: #{@item_2.name}")
    end
  end

