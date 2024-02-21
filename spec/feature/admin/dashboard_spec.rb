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
      it 'has a list with the top 5 customers with largest num of transactions' do
         visit "/admin"

         expect(page).to have_content()
      end
   end
end