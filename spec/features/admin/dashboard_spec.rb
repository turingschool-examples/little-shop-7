require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
   describe 'as an Admin' do
      before(:each) do
            
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
      xit 'has a list with the top 5 customers with largest num of transactions' do
         visit "/admin"

         cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
         cust_2 = Customer.create!(first_name: "John", last_name: "Smith")
         cust_3 = Customer.create!(first_name: "Jane", last_name: "Perry")
         cust_4 = Customer.create!(first_name: "Buzz", last_name: "Lightyeay")
         cust_5 = Customer.create!(first_name: "Patrick", last_name: "Karl")
         cust_6 = Customer.create!(first_name: "Igor", last_name: "Mag")
         cust_7 = Customer.create!(first_name: "Selena", last_name: "Has")
         invoice = FactoryBot.create(:invoice)
         transaction = Transaction.create!(invoice: invoice, result: 0)
         binding.pry 

         expect(page).to have_content(customer.name)
         expect(page).to have_content("#{customer.transactions_count} transactions")
    
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