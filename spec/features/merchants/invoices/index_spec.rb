require 'rails_helper' 

RSpec.describe "Merchants Invoices Index", type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")


    @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")


    @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")


    @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)


    @invoiceitem = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id)

  end

  describe "US14. When I visit my merchant's invoices index " do 
    it "then I see all of the invoices that include at least one of my merchant's items and its ID" do
      visit "/merchants/#{@merchant1.id}/invoices"
      save_and_open_page
      expect(page).to have_content("#{@invoice1.id}")
      
    end

    it "each ID links to the merchant invoice show page" do
      visit "/merchants/#{@merchant1.id}/invoices"
    
      click_link "#{@invoice1.id}"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    end
  end 
end