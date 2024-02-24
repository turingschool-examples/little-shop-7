require "rails_helper"

RSpec.describe "merchant index" do
  before(:each) do
    @customer1 = Customer.create(first_name: "Martin", last_name: "Chavez")
    @customer2 = Customer.create(first_name: "Rodrigo", last_name: "Alberto")

    
    @merchant1 = Merchant.create(name: "Merchant A")
    @merchant2 = Merchant.create(name: "Merchant B")

    
    @item1 = Item.create(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
    @item2 = Item.create(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
    @item3 = Item.create(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2)
    @item4 = Item.create(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2)

    
    @invoice1 = Invoice.create(status: 1, customer: @customer1)
    @invoice2 = Invoice.create(status: 1, customer: @customer2)

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 2, unit_price: 2000, status: 1)
    @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 3, unit_price: 4000, status: 1)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: 0)
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: "9876543210987654", credit_card_expiration_date: "09/24", result: 1)

  end

  describe 'US 6' do
   describe 'Merchant Items Index Page' do
     it 'displays list of the names of all of my items And I do not see items for any other merchant' do
       visit merchant_items_path(@merchant1)
        # When I visit my merchant items index page (merchants/:merchant_id/items)
        expect(page).to have_content('Merchant Name: Merchant A')

        expect(page).to have_content('Item name: Gum')
        expect(page).to have_content('Item name: Mint')
        # I see a list of the names of all of my items

        expect(page).to_not have_content('Apple')
        expect(page).to_not have_content('orange')
        # And I do not see items for any other merchant
     end
   end
  end
end