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
         
         @invoice1 = create(:invoice, customer_id: @customer_1.id, status: 0)
         @invoice6 = create(:invoice, customer_id: @customer_1.id, status: 1)
         
         @invoice2 = create(:invoice, customer_id: @customer_2.id, status: 0)
         @invoice7 = create(:invoice, customer_id: @customer_2.id, status: 1)
         @invoice8 = create(:invoice, customer_id: @customer_2.id, status: 1)
         
         @invoice3 = create(:invoice, customer_id: @customer_3.id, status: 0)
         
         @invoice4 = create(:invoice, customer_id: @customer_5.id, status: 1)
         @invoice5 = create(:invoice, customer_id: @customer_5.id, status: 1)
         @invoice9 = create(:invoice, customer_id: @customer_5.id, status: 1)
         @invoice10 = create(:invoice, customer_id: @customer_5.id, status: 1)
         
         transaction1 = create(:transaction, invoice: @invoice1, result: 0)
         transaction2 = create(:transaction, invoice: @invoice2, result: 0)
         transaction3 = create(:transaction, invoice: @invoice3, result: 0)
         transaction4 = create(:transaction, invoice: @invoice4, result: 0)
         transaction5 = create(:transaction, invoice: @invoice5, result: 0)
         transaction6 = create(:transaction, invoice: @invoice6, result: 0)
         transaction7 = create(:transaction, invoice: @invoice7, result: 0)
         transaction8 = create(:transaction, invoice: @invoice8, result: 0)
         transaction9= create(:transaction, invoice: @invoice9, result: 0)
         transaction10 = create(:transaction, invoice: @invoice10, result: 0)
            
         @invoice_item_1 = create(:invoice_item, status: 0, invoice: @invoice1)
         @invoice_item_2 = create(:invoice_item, status: 0, invoice: @invoice2)
         @invoice_item_3 = create(:invoice_item, status: 0, invoice: @invoice3)
         # require 'pry' ; binding.pry
      end

      # User Story 19
      it 'has a header indicating I am on the admin dashboard' do
         visit admin_path

         expect(page).to have_content("Admin Dashboard")
      end

      # User Story 20
      it 'has a link to merchants index and invoices index' do
         visit admin_path

         expect(page).to have_link("Merchants Index", href: admin_merchants_path)
         expect(page).to have_link("Invoices Index", href: admin_invoices_path)
      end

      # User Story 21
      it 'has a list with the top 5 customers with largest num of transactions' do
         visit admin_path

         within "#top_customers" do 
            expect(page).to have_content("Top Customers")

            # Use string interpolation to get the number of transactions
            within "#customer_#{@customer_5.id}" do 
               expect(page).to have_content(@customer_5.first_name)
               expect(page).to have_content("Number of Transactions: #{@customer_5.transactions.count}")
            end

            within "#customer_#{@customer_2.id}" do 
               expect(page).to have_content(@customer_2.first_name)
               expect(page).to have_content("Number of Transactions: #{@customer_2.transactions.count}")
            end

            within "#customer_#{@customer_1.id}" do 
               expect(page).to have_content(@customer_1.first_name)
               expect(page).to have_content("Number of Transactions: #{@customer_1.transactions.count}")
            end

            within "#customer_#{@customer_3.id}" do 
               expect(page).to have_content(@customer_3.first_name)
               expect(page).to have_content("Number of Transactions: #{@customer_3.transactions.count}")
            end

            within "#customer_#{@customer_4.id}" do 
               expect(page).to have_content(@customer_4.first_name)
               expect(page).to have_content("Number of Transactions: #{@customer_4.transactions.count}")
            end
         end
      end

      # User Story 22 
      it 'displays a list of incomplete invoice IDs' do 
         visit admin_path
         within "#incomplete_invoices" do
            expect(page).to have_content('Incomplete Invoices')

            within "#invoice-#{@invoice1.id}" do
               expect(page).to have_content(@invoice1.id)
               expect(page).to have_link("#{@invoice1.id}", href: admin_invoice_path(@invoice1.id))
            end

            within "#invoice-#{@invoice2.id}" do
               expect(page).to have_content(@invoice2.id)
               expect(page).to have_link("#{@invoice2.id}", href: admin_invoice_path(@invoice2.id))
            end

            within "#invoice-#{@invoice3.id}" do
               expect(page).to have_content(@invoice3.id)
               expect(page).to have_link("#{@invoice3.id}", href: admin_invoice_path(@invoice3.id))
            end
         end
      end

      # User Story 23 
      it 'displays the date that the invoice was created' do 
         visit admin_path

         within "#incomplete_invoices" do
            expect(page).to have_content('Incomplete Invoices')

            within "#invoice-#{@invoice1.id}" do
               expect(page).to have_content(@invoice1.id)
               expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %e, %Y"))
            end

            within "#invoice-#{@invoice2.id}" do
               expect(page).to have_content(@invoice2.id)
               expect(page).to have_content(@invoice2.created_at.strftime("%A, %B %e, %Y"))
            end

            within "#invoice-#{@invoice3.id}" do
               expect(page).to have_content(@invoice3.id)
               expect(page).to have_content(@invoice3.created_at.strftime("%A, %B %e, %Y"))
            end
         end
      end 
   end
end