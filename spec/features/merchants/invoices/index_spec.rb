require "rails_helper"

RSpec.describe "Merchant invoice index" do
  describe "US 14" do
    #When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
    #Then I see all of the invoices that include at least one of my merchant's items
    #And for each invoice I see its id
    #And each id links to the merchant invoice show page
    before :each do
      @merchant = create(:merchant)
      
      @item = create(:item, merchant:@merchant)
      @item2 = create(:item, merchant: @merchant)
    
      @customer1 = create(:customer)
      @customer2 = create(:customer)

      @invoice1 = create(:invoice, customer: @customer1)
      @invoice2 = create(:invoice, customer: @customer2)
      @non_merchant_invoice = create(:invoice, customer: @customer2)
      
      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice1, status: 0)
      @invoice_item = create(:invoice_item, item: @item2, invoice: @invoice2, status: 0)
    end

    it "Shows all invoices from a particular merchant" do
      
      
      visit merchant_invoices_path("#{@merchant.id}")
      
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to_not have_content(@non_merchant_invoice.id)
    end

    it "has a link to each merchant invoice show page" do
      visit merchant_invoices_path("#{@merchant.id}")
      
      click_link("#{@invoice1.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1.id))
    end
  end
end