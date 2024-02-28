require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
    describe 'User story 32' do
        before do
            @nico = Customer.create!(first_name: "Nico", last_name: "Shantii")
            @wolf = Customer.create!(first_name: "Wolf", last_name: "Goode")
            @invoice_1 = Invoice.create!(customer_id: @nico.id)
            @invoice_2 = Invoice.create!(customer_id: @nico.id)
        end

        it 'shows a clickable list of all invoice ids in the system' do
            #As an admin,
            #When I visit the admin Invoices index (/admin/invoices)
            visit admin_invoices_path
            # Then I see a list of all Invoice ids in the system
            expect(page).to have_content(@invoice_1.id)
            expect(page).to have_content(@invoice_2.id)
            # Each id links to the admin invoice show page
            expect(page).to have_link(@invoice_1.id)
            expect(page).to have_link(@invoice_2.id)

            click_link(@invoice_1.id)
            expect(current_path).to eq(admin_invoice_path(@invoice_1))

            visit admin_invoices_path

            click_link(@invoice_2.id)
            expect(current_path).to eq(admin_invoice_path(@invoice_2))
        end
    end
end
