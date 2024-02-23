require 'rails_helper'


RSpec.describe 'Admin Dashboard', type: :feature do
   describe 'as an Admin' do
      before(:each) do
         @cust_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         @cust_2 = create(:customer, first_name: "John", last_name: "Smith")
         @cust_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         @cust_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         @cust_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         
         @green = Merchant.create!(name: "Green Inc")
         @black = Merchant.create!(name: "Black Inc")
         @brown = Merchant.create!(name: "Brown Inc")
         
         item1 = FactoryBot.create(:item, name: "table", merchant_id: @green.id)
         item2 = FactoryBot.create(:item, name: "pen", merchant_id: @black.id)
         item3 = FactoryBot.create(:item, name: "paper", merchant_id: @brown.id)
         
         invoice1 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)
         invoice6 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)
         
         invoice2 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
         invoice7 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
         invoice8 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
         
         
         invoice3 = FactoryBot.create(:invoice, customer_id: @cust_3.id, status: 1)
         
         invoice4 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
         invoice5 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
         invoice9 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
         invoice10 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
         
         transaction1 = FactoryBot.create(:transaction, invoice: invoice1, result: 0)
         transaction2 = FactoryBot.create(:transaction, invoice: invoice2, result: 0)
         transaction3 = FactoryBot.create(:transaction, invoice: invoice3, result: 0)
         transaction4 = FactoryBot.create(:transaction, invoice: invoice4, result: 0)
         transaction5 = FactoryBot.create(:transaction, invoice: invoice5, result: 0)
         transaction6 = FactoryBot.create(:transaction, invoice: invoice6, result: 0)
         transaction7 = FactoryBot.create(:transaction, invoice: invoice7, result: 0)
         transaction8 = FactoryBot.create(:transaction, invoice: invoice8, result: 0)
         transaction9= FactoryBot.create(:transaction, invoice: invoice9, result: 0)
         transaction10 = FactoryBot.create(:transaction, invoice: invoice10, result: 0)
         # require 'pry'; binding.pry
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
            expect(page).to have_content("#{customer.transactions_count} transactions")

            within "#customer_#{@cust_5.id}" do 
               expect(page).to have_content(@cust_5.first_name)
               expect(page).to have_content("Number of Transactions: 31")
            end

            within "#customer_#{@cust_2.id}" do 
               expect(page).to have_content(@cust_2.first_name)
               expect(page).to have_content("Number of Transactions: 27")
            end

            within "#customer_#{@cust_1.id}" do 
               expect(page).to have_content(@cust_1.first_name)
               expect(page).to have_content("Number of Transactions: 23")
            end

            within "#customer_#{@cust_3.id}" do 
               expect(page).to have_content(@cust_3.first_name)
               expect(page).to have_content("Number of Transactions: 19")
            end

            within "#customer_#{@cust_4.id}" do 
               expect(page).to have_content(@cust_4.first_name)
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