require 'rails_helper'

RSpec.describe 'Admin Invoices Show Page' do
    describe 'User Story 33' do
        before do
            @nico = Customer.create!(first_name: "Nico", last_name: "Shantii")
            @wolf = Customer.create!(first_name: "Wolf", last_name: "Goode")
            @invoice_1 = Invoice.create!(status: "In Progress", customer_id: @nico.id)
            @invoice_2 = Invoice.create!(status: "Completed", customer_id: @wolf.id)
        end

        it 'shows invoice info - invoice id, status, invoice created_at date (Week-Day, Month dd, yyyy), customer first and last name' do
            # As an admin,
            # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
            visit admin_invoice_path("#{@invoice_1.id}")
            # Then I see information related to that invoice including:
            # Invoice id
            expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
            # Invoice status
            expect(page).to have_content("Status: #{@invoice_1.status}")
            # Invoice created_at date in the format "Monday, July 18, 2019"
            expect(page).to have_content("Created At: #{@invoice_1.formatted_created_at}")
            # Customer first and last name
            nico = Customer.find(@invoice_1.customer_id)
            expect(page).to have_content("Customer First Name: #{nico.first_name}")
            expect(page).to have_content("Customer Last Name: #{nico.last_name}")
            expect(page).to_not have_content("Wolf")
        end
    end

    describe 'User story 34, Invoice Item Information' do
        let!(:items) { create_list(:item, 4) }
        let!(:invoice) { create(:invoice) }
        let!(:invoice_items) do
            items.map do |item|
                create(:invoice_item, item: item, invoice: invoice, status: "pending")
            end
        end
        
        it 'shows all items on invoice including Item name, quantity ordered, price the Item sold for, Invoice Item status' do
            item1 = FactoryBot.create(:item)
            # As an admin
            # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
            visit admin_invoice_path(invoice)
            invoice_items.each do |invoice_item|
                # Then I see all of the items on the invoice including:
                # Item name
                expect(page).to have_content("Item name: #{invoice_item.item.name}")
                # The quantity of the item ordered
                expect(page).to have_content("Quantity ordered: #{invoice_item.quantity}")
                # The price the Item sold for
                expect(page).to have_content("Item price: #{invoice_item.unit_price}")
            end
            # The Invoice Item status
            expect(page).to have_content("Status: pending", count: 4)
            expect(page).to_not have_content(item1.name)
        end
    end
end