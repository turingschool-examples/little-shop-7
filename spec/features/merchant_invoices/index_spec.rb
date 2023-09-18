require "rails_helper"

# Merchant Invoices Index
# As a merchant,
# When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page

  


RSpec.describe "the merchant's invoice index" do

  describe "complete invoices list" do
    it "lists all invoice id's in the system that have an item" do
      
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_1.id)
      @item_3 = create(:item, merchant_id: @merchant_2.id)
    
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_1.id)
      @invoice_3 = create(:invoice, customer_id: @customer_1.id)
    
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id)

      visit "/merchants/#{@merchant_1.id}/invoices"

      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).not_to have_link("#{@invoice_3.id}")
    end
  end
end