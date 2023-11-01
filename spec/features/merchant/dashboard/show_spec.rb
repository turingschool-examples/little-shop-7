require "rails_helper"

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hannah's Handbags")
    @merchant2 = Merchant.create!(name: "Jason's Furniture")

    @customer1 = Customer.create!(first_name: "John", last_name: "Jacobs")
    @customer2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
    @customer3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
    @customer4 = Customer.create!(first_name: "Harry", last_name: "Potter")
    @customer5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
    @customer6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")
    @customer7 = Customer.create!(first_name: "Jackie", last_name: "Chan")

    @item1 = Item.create(name: "Large Handbag", description: "Brown Leather", unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create(name: "Small Handbag", description: "Black Fabric", unit_price: 80, merchant_id: @merchant1.id)
    @item3 = Item.create(name: "Large Couch", description: "Grey Fabric", unit_price: 400, merchant_id: @merchant2.id)
    
    @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice8 = Invoice.create!(status: 2, customer_id: @customer7.id)

    @invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item2.id, invoice_id: @invoice2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item1.id, invoice_id: @invoice3.id)
    @invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item2.id, invoice_id: @invoice4.id)
    @invoice_item5 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item1.id, invoice_id: @invoice5.id)
    @invoice_item6 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item2.id, invoice_id: @invoice6.id)
    @invoice_item7 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 2, item_id: @item1.id, invoice_id: @invoice7.id)

    @transaction1 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice4.id)
    @transaction5 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice5.id)
    @transaction6 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice6.id)
    @transaction7 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice7.id)
    
  end

  describe "As a merchant" do
    #User Story 1
    describe "When I visit my merchant dashboard" do
      it "I see the name of my merchant" do

        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content(@merchant1.name)
        expect(page).to_not have_content(@merchant2.name)
      end
      
      it "I see a link to my merchant items index" do 
        
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        expect(page).to have_link("Items")
        click_link("Items")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      end

      it "I see a link to my merchant invoices index" do 
        visit "/merchants/#{@merchant2.id}/dashboard"
        
        expect(page).to have_link("Invoices")
        click_link("Invoices")
        
        expect(current_path).to eq("/merchants/#{@merchant2.id}/invoices")
      end

      #User Story 3
      describe "Merchant Dashboard Statistics - Favorite Customers" do
        it "shows the names of the top 5 customers and I see their number of successful transactions with that merchant" do
          visit "/merchants/#{@merchant1.id}/dashboard"

          expect(page).to_not have_content("John Jacobs")
          expect(page).to have_content("Susan Robinson Successful Transactions: 1")
          expect(page).to have_content("Jessica Simpson Successful Transactions: 1")
          expect(page).to have_content("Harry Potter Successful Transactions: 1")
          expect(page).to have_content("Ron Weasley Successful Transactions: 1")
          expect(page).to have_content("Nicole Johnson Successful Transactions: 1")
          expect(page).to have_content("Jackie Chan Successful Transactions: 1")
        end
      end
    end
  end
end