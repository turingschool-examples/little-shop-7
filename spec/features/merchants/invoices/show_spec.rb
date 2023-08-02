require "rails_helper"

RSpec.describe "Merchant invoice show" do
  describe "US15, 16 & 17" do
              
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
    #User story 15
    it "Visits merchants invoice show page" do
      visit merchant_invoice_path(@merchant, @invoice.id)
      
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end

    describe "User Story 16" do

      it "Shows all the items attached to an invoice" do
        visit merchant_invoice_path(@merchant, @invoice.id)


        expect(page).to have_content(@item.name)
        expect(page).to have_content(@invoice_item.quantity)
        expect(page).to have_content("$8.99")
        expect(page).to have_content(@invoice_item3.status)
        expect(page).to_not have_content(@item5.name)
      end
    end

    describe "User Story 17" do
      before :each do
        @merchant3 = create(:merchant)
        
        @item5 = create(:item, merchant:@merchant3)
        @item6 = create(:item, merchant:@merchant3)
        @item7 = create(:item, merchant:@merchant3)
        
      
        @customer5 = create(:customer)
  
        @invoice5 = create(:invoice, customer: @customer5)
        
        @invoice_item5 = create(:invoice_item, item: @item7, invoice: @invoice5, status: 0, quantity: 1, unit_price: 800)

        @invoice_item6 = create(:invoice_item, item: @item6, invoice: @invoice5, status: 0,quantity: 1, unit_price: 800)

        @invoice_item7 = create(:invoice_item, item: @item2, invoice: @invoice5, status: 0, quantity: 2, unit_price: 800)
        
      end
      it "Show the total revenue of an invoice " do
        visit merchant_invoice_path(@merchant3, @invoice5.id)
        expect(page).to have_content("$32.00")
      end
    end
  end
end