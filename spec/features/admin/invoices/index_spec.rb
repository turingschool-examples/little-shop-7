require 'rails_helper'

RSpec.describe 'Admin Invoices Index', type: :feature do
   describe 'as an admin' do
      before(:each) do
         @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
         @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         
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
      end

      # User Story 32
      it 'has a list of all Invoices Ids in the system with a link to the id show page' do
         visit admin_invoices_path

         expect(page).to have_content("Invoices")

         expect(page).to have_link("Invoice #{@customer_1.invoices.first.id}", href: admin_invoice_path(@customer_1.invoices.first.id))
         expect(page).to have_link("Invoice #{@customer_1.invoices.last.id}", href: admin_invoice_path(@customer_1.invoices.last.id))

         expect(page).to have_link("Invoice #{@customer_2.invoices.first.id}", href: admin_invoice_path(@customer_2.invoices.first.id))
         expect(page).to have_link("Invoice #{@customer_2.invoices.last.id}", href: admin_invoice_path(@customer_2.invoices.last.id))

         expect(page).to have_link("Invoice #{@customer_3.invoices.first.id}", href: admin_invoice_path(@customer_3.invoices.first.id))
         expect(page).to have_link("Invoice #{@customer_3.invoices.last.id}", href: admin_invoice_path(@customer_3.invoices.last.id))

         expect(page).to have_link("Invoice #{@customer_4.invoices.first.id}", href: admin_invoice_path(@customer_4.invoices.first.id))
         expect(page).to have_link("Invoice #{@customer_4.invoices.last.id}", href: admin_invoice_path(@customer_4.invoices.last.id))

         expect(page).to have_link("Invoice #{@customer_5.invoices.first.id}", href: admin_invoice_path(@customer_5.invoices.first.id))
         expect(page).to have_link("Invoice #{@customer_5.invoices.last.id}", href: admin_invoice_path(@customer_5.invoices.last.id))
         
         expect(page).to have_link("Invoice #{@invoice1.id}", href: admin_invoice_path(@invoice1.id))
         expect(page).to have_link("Invoice #{@invoice2.id}", href: admin_invoice_path(@invoice2.id))
         expect(page).to have_link("Invoice #{@invoice3.id}", href: admin_invoice_path(@invoice3.id))
         expect(page).to have_link("Invoice #{@invoice4.id}", href: admin_invoice_path(@invoice4.id))
         expect(page).to have_link("Invoice #{@invoice5.id}", href: admin_invoice_path(@invoice5.id))
      end
   end
end