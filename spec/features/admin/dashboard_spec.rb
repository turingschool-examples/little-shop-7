require 'rails_helper'


RSpec.describe 'Admin Dashboard', type: :feature do
   describe 'as an Admin' do
      before(:each) do
         @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
         @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         
         @green_merchant = Merchant.create!(name: "Green Inc")
         @black_merchant = Merchant.create!(name: "Black Inc")
         @brown_merchant = Merchant.create!(name: "Brown Inc")
         
         item1 = create(:item, name: "table", merchant_id: @green_merchant.id)
         item2 = create(:item, name: "pen", merchant_id: @black_merchant.id)
         item3 = create(:item, name: "paper", merchant_id: @brown_merchant.id)
         
         invoice1 = create(:invoice, customer_id: @customer_1.id, status: 1)
         invoice6 = create(:invoice, customer_id: @customer_1.id, status: 1)
         
         invoice2 = create(:invoice, customer_id: @customer_2.id, status: 1)
         invoice7 = create(:invoice, customer_id: @customer_2.id, status: 1)
         invoice8 = create(:invoice, customer_id: @customer_2.id, status: 1)
         
         
         invoice3 = create(:invoice, customer_id: @customer_3.id, status: 1)
         
         invoice4 = create(:invoice, customer_id: @customer_5.id, status: 1)
         invoice5 = create(:invoice, customer_id: @customer_5.id, status: 1)
         invoice9 = create(:invoice, customer_id: @customer_5.id, status: 1)
         invoice10 = create(:invoice, customer_id: @customer_5.id, status: 1)
         
         transaction1 = create(:transaction, invoice: invoice1, result: 0)
         transaction2 = create(:transaction, invoice: invoice2, result: 0)
         transaction3 = create(:transaction, invoice: invoice3, result: 0)
         transaction4 = create(:transaction, invoice: invoice4, result: 0)
         transaction5 = create(:transaction, invoice: invoice5, result: 0)
         transaction6 = create(:transaction, invoice: invoice6, result: 0)
         transaction7 = create(:transaction, invoice: invoice7, result: 0)
         transaction8 = create(:transaction, invoice: invoice8, result: 0)
         transaction9= create(:transaction, invoice: invoice9, result: 0)
         transaction10 = create(:transaction, invoice: invoice10, result: 0)
            
      end

      # User Story 19
      it 'has a header indicating I am on the admin dashboard' do
         visit "/admin"

         expect(page).to have_content("Admin Dashboard")
      end

      # User Story 20
      it 'has a link to merchants index and invoices index' do
         visit "/admin"

         expect(page).to have_link("Merchants Index", href: "/admin/merchants")
         expect(page).to have_link("Invoices Index", href: "/admin/invoices")
      end

      # User Story 21
      it 'has a list with the top 5 customers with largest num of transactions' do
         visit "/admin"

         within "#top_customers" do 
            expect(page).to have_content("Top Customers")

            within "#customer_#{@customer_5.id}" do 
               expect(page).to have_content(@customer_5.first_name)
               expect(page).to have_content("Number of Transactions: 31")
            end

            within "#customer_#{@customer_2.id}" do 
               expect(page).to have_content(@customer_2.first_name)
               expect(page).to have_content("Number of Transactions: 27")
            end

            within "#customer_#{@customer_1.id}" do 
               expect(page).to have_content(@customer_1.first_name)
               expect(page).to have_content("Number of Transactions: 23")
            end

            within "#customer_#{@customer_3.id}" do 
               expect(page).to have_content(@customer_3.first_name)
               expect(page).to have_content("Number of Transactions: 19")
            end

            within "#customer_#{@customer_4.id}" do 
               expect(page).to have_content(@customer_4.first_name)
               expect(page).to have_content("Number of Transactions: 15")
            end
         end
      end

      # User Story 22 
      xit 'displays a list of incomplete invoice IDs' do 

         customer = Customer.create!(first_name: "John", last_name: "Smith")

         brand = Merchant.create!(name: "Brand")

         item = Item.create!(name: "Table", description: "Wood", unit_price: 100, merchant: brand)

         invoice = Invoice.create!(customer: customer)
         InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 100, status: :pending)


         visit '/admin'

         expect(page).to have_content('Incomplete Invoices')
         expect(page).to have_link(invoice.id, href: "/admin/invoices/#{invoice.id}")
  
      end

      # User Story 23 
      xit 'displays the date that the invoice was created' do 

         customer = Customer.create!(first_name: "John", last_name: "Smith")

         item = Item.create!(name: "Table", description: "Wood", unit_price: 100, merchant: brand)

         old_invoice = Invoice.create!(customer: customer, created_at: Time.current - 8.days, status: :in_progress)
         new_invoice = Invoice.create!(customer: customer, created_at: Time.current - 2.days, status: :in_progress)

         InvoiceItem.create!(item: item, invoice: old_invoice, quantity: 1, unit_price: 100, status: :pending)
         InvoiceItem.create!(item: item, invoice: new_invoice, quantity: 1, unit_price: 100, status: :pending)

         expect(page).to have_content(old_invoice.id)
         expect(page).to have_content(new_invoice.id)
         expect(page).to have_content(old_invoice.created_at.strftime("%A, %B %e, %Y"))
         expect(page).to have_content(new_invoice.created_at.strftime("%A, %B %e, %Y"))
      end 
   end
end