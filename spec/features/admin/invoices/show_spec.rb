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
        before do
            @nico = Customer.create!(first_name: "Nico", last_name: "Shantii")
            @wolf = Customer.create!(first_name: "Wolf", last_name: "Goode")
            @invoice_1 = Invoice.create!(status: "In Progress", customer_id: @nico.id)
            @invoice_2 = Invoice.create!(status: "Completed", customer_id: @wolf.id)
            @organic_rocks = Item.create!(name: "Organic Rocks", unit_price: 77)
            @stick = Item.create!(name: "Stick", unit_price: 22)
            @vintage_water = Item.create!(name: "Vintage Water", unit_price: 11)
            @invoice_item_1 = InvoiceItem.create!(
                invoice: @invoice_1,
                item: @organic_rocks,
                quantity: 3,
                unit_price: @organic_rocks.price,
                status: 0
            )
            @invoice_item_2 = InvoiceItem.create!(
                invoice: @invoice_1,
                item: @sticks,
                quantity: 7,
                unit_price: @sticks.price,
                status: 0
            )
            @invoice_item_3 = InvoiceItem.create!(
                invoice: @invoice_2,
                item: @vintage_water,
                quantity: 10,
                unit_price: @vintage_water.price,
                status: 2
            )
        end

        it 'shows all items on invoice including Item name, quantity ordered, price the Item sold for, Invoice Item status' do
            # As an admin
            # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
            visit admin_invoice_path("#{@invoice_1.id}")
            # Then I see all of the items on the invoice including:
            # Item name
            expect(page).to have_content("Item name: #{@invoice_item_1.name}")
            expect(page).to have_content("Item name: #{@invoice_item_2.name}")
            # The quantity of the item ordered
            expect(page).to have_content("Quantity ordered: #{@invoice_item_1.quantity}")
            expect(page).to have_content("Quantity ordered: #{@invoice_item_2.quantity}")
            # The price the Item sold for
            expect(page).to have_content("Item price: #{@invoice_item_1.unit_price}")
            expect(page).to have_content("Item price: #{@invoice_item_2.unit_price}")
            # The Invoice Item status
            expect(page).to have_content("Status: #{@invoice_item_1.status}")
            expect(page).to have_content("Status: #{@invoice_item_2.status}")
            
            expect(page).to_not have_content("Item name: #{@invoice_item_3.name}")

        end
    end
end