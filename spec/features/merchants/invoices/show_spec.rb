require "rails_helper"

RSpec.describe "Merchant invoice show" do
  describe "US15" do
              #     As a merchant
              # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
              # Then I see information related to that invoice including:
              # - Invoice id
              # - Invoice status
              # - Invoice created_at date in the format "Monday, July 18, 2019"
              # - Customer first and last name
    before :each do
      @merchant = create(:merchant)
      
      @item = create(:item, merchant:@merchant)
    
      @customer1 = create(:customer)

      @invoice1 = create(:invoice, customer: @customer1)
      
      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice1, status: 0)
      
    end
    it "Visits merchants invoice show page" do
      visit merchant_invoice_path(@merchant, @invoice1.id)

      expect(page).to have_content(@invoice1.status)
    end
  end
end