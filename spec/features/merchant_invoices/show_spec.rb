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
  end