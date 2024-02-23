require 'rails_helper'


RSpec.describe 'Admin Merchant Edit page', type: :feature do
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

      it 'has the name of the merchant in the form' do
         visit edit_admin_merchant_path(@green_merchant.id)

         expect(page).to have_content(@green_merchant.name)

         within "#edit_merchant" do
            expect(page).to have_field('Name', with: "#{@green_merchant.name}")
         end
      end

      it 'redirects back to admin show page with updated info' do
         visit edit_admin_merchant_path(@green_merchant.id)

         expect(page).to have_content(@green_merchant.name)

         within "#edit_merchant" do
            expect(page).to have_field('Name', with: "#{@green_merchant.name}")

            fill_in 'Name', with: 'Blue LLC'

            click_on "Update Merchant"

            expect(current_path).to eq(admin_merchant_path(@green_merchant.id))
         end

         expect(page).to have_content("Merchant Successfully Updated")
      end

      it 'redirects back to admin edit page if no info' do
         visit edit_admin_merchant_path(@green_merchant.id)

         expect(page).to have_content(@green_merchant.name)

         within "#edit_merchant" do
            expect(page).to have_field('Name', with: "#{@green_merchant.name}")

            fill_in 'Name', with: ' '

            click_on "Update Merchant"

            expect(current_path).to eq(edit_admin_merchant_path(@green_merchant.id))
         end

         expect(page).to have_content("Error:")
      end
   end
end