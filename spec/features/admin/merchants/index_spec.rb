require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
   describe 'as an admin' do
      before(:each) do
         @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
         @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         
         @green_merchant = Merchant.create!(name: "Green Inc")
         @black_merchant = Merchant.create!(name: "Black Inc")
         @brown_merchant = Merchant.create!(name: "Brown Inc")
         
         item1 = create(:item, name: "table", merchant: @green_merchant)
         item2 = create(:item, name: "pen", merchant: @black_merchant)
         item3 = create(:item, name: "paper", merchant: @brown_merchant)
         
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
      end

      # User Story 24
      it 'displays the name of each merchant' do
         visit admin_merchants_path

         expect(page).to have_content("Merchants")

         within "#merchant-#{@green_merchant.id}" do
            expect(page).to have_content(@green_merchant.name)
         end

         within "#merchant-#{@black_merchant.id}" do
            expect(page).to have_content(@black_merchant.name)
         end

         within "#merchant-#{@brown_merchant.id}" do
            expect(page).to have_content(@brown_merchant.name)
         end
      end

      it 'has a link for each merchant' do
         visit admin_merchants_path

         expect(page).to have_content("Merchants")

         within "#merchant-#{@green_merchant.id}" do
            expect(page).to have_link("#{@green_merchant.name}", href: admin_merchant_path(@green_merchant.id))

            click_on(@green_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@green_merchant.id))
         end

         visit admin_merchants_path

         within "#merchant-#{@black_merchant.id}" do
            expect(page).to have_link("#{@black_merchant.name}", href: admin_merchant_path(@black_merchant.id))

            click_on(@black_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@black_merchant.id))
         end

         visit admin_merchants_path

         within "#merchant-#{@brown_merchant.id}" do
            expect(page).to have_link("#{@brown_merchant.name}", href: admin_merchant_path(@brown_merchant.id))

            click_on(@brown_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@brown_merchant.id))
         end
      end
   end
end