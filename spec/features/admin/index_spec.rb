require 'rails_helper'

RSpec.describe 'Admin dashboard' do
    let(:merchant) { FactoryBot.create(:merchant) }
    let(:item) { FactoryBot.create(:item, merchant: merchant) }
    let(:top_customers) { FactoryBot.create_list(:customer, 5) }
    let(:customers) { FactoryBot.create_list(:customer, 5) }
    

    describe 'User story 19' do
        it 'displays admin dashboard header' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_path
            # Then I see a header indicating that I am on the admin dashboard
            expect(page).to have_content("Little Etsy Shop Admin Dashboard")
        end
    end

    describe 'User story 20' do
        it 'displays admin dashboard links to merchant and invoice index' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_path
            # Then I see a link to the admin merchants index (/admin/merchants)
            expect(page).to have_link("Merchants", href: admin_merchants_path)
            # And I see a link to the admin invoices index (/admin/invoices)
            expect(page).to have_link("Invoices", href: admin_invoices_path)
        end
    end

    describe 'User Story 21' do
        before do
            top_customers.each do |customer|
              invoice = FactoryBot.create(:invoice, customer: customer)
              invoice.items = [item]
              FactoryBot.create_list(:transaction, Random.rand(2..5), invoice: invoice)
              invoice.save!
            end
            customers.each do |customer|
              invoice = FactoryBot.create(:invoice, customer: customer)
              invoice.items = [item]
              FactoryBot.create_list(:transaction, 1, invoice: invoice)
              invoice.save!
            end
        end
        
        it 'displays top 5 customers and count of successful transactions' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_path
            # Then I see the names of the top 5 customers
            # who have conducted the largest number of successful transactions
            # And next to each customer name I see the number of successful transactions they have
            # conducted
            expect(page).to have_content("Little Etsy's Favorite Customers")

            top_customers.each do |top_customer|
                within "#top_customer-#{top_customer.id}" do
                    expect(page).to have_content("#{top_customer.first_name} #{top_customer.last_name}: #{top_customer.transactions.count} transactions")
                end
            end

            customers.each do |customer|
                expect(page).to_not have_content("#{customer.first_name} #{customer.last_name}")
            end
        end
    end

    describe 'User story 22' do
        let(:item_1) { FactoryBot.create(:item, merchant: merchant) }
        let(:item_2) { FactoryBot.create(:item, merchant: merchant) }
        let(:item_3) { FactoryBot.create(:item, merchant: merchant) }
        let(:customer) { FactoryBot.create(:customer) }

        let(:invoice_1) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 3.day) }
        let(:invoice_2) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 2.day) }
        let(:invoice_3) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 5.day) }

        let!(:invoice_item_1) { InvoiceItem.create!(invoice: invoice_1, item: item_1, status: "packaged") }
        let!(:invoice_item_2) { InvoiceItem.create!(invoice: invoice_2, item: item_2, status: "pending") }
        let!(:invoice_item_3) { InvoiceItem.create!(invoice: invoice_3, item: item_3, status: "shipped") }
        
        it 'displays ids of invoices that have items in not shipped status' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_path
            # Then I see a section for "Incomplete Invoices"
            expect(page).to have_content("Little Etsy's Incomplete Invoices")
            # In that section I see a list of the ids of all invoices
            # That have items that have not yet been shipped
            expect(page).to have_content("Invoice: #{invoice_item_1.invoice_id}")
            expect(page).to have_content("Invoice: #{invoice_item_2.invoice_id}")
            expect(page).to_not have_content("Invoice: #{invoice_item_3.invoice_id}")
            # And each invoice id links to that invoice's admin show page
            expect(page).to have_link("Invoice: #{invoice_item_1.invoice_id}", href: admin_invoice_path(invoice_1))
            expect(page).to have_link("Invoice: #{invoice_item_2.invoice_id}", href: admin_invoice_path(invoice_2))
        end
    end

    describe 'User story 23' do
        include Admin::DashboardsHelper

        let(:item_1) { FactoryBot.create(:item, merchant: merchant) }
        let(:item_2) { FactoryBot.create(:item, merchant: merchant) }
        let(:item_3) { FactoryBot.create(:item, merchant: merchant) }
        let(:customer) { FactoryBot.create(:customer) }

        let(:invoice_1) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 3.day) }
        let(:invoice_2) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 2.day) }
        let(:invoice_3) { FactoryBot.create(:invoice, customer: customer, created_at: Time.current - 5.day) }

        let!(:invoice_item_1) { InvoiceItem.create!(invoice: invoice_1, item: item_1, status: "packaged") }
        let!(:invoice_item_2) { InvoiceItem.create!(invoice: invoice_2, item: item_2, status: "pending") }
        let!(:invoice_item_3) { InvoiceItem.create!(invoice: invoice_3, item: item_3, status: "shipped") }

        it 'displays invoice dates from oldest to newest in Weekday, Month Day, Year format' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_path
            # In the section for "Incomplete Invoices",
            # Next to each invoice id I see the date that the invoice was created
            # And I see the date formatted like "Monday, July 18, 2019"
            # And I see that the list is ordered from oldest to newest
            within "#invoice_item-#{invoice_item_1.invoice_id}" do
                expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
                expect(page).to_not have_content(format_created_at(invoice_2.created_at))
            end

            within "#invoice_item-#{invoice_item_2.invoice_id}" do
                expect(page).to have_content(invoice_2.created_at.strftime("%A, %B %d, %Y"))
                expect(page).to_not have_content(format_created_at(invoice_1.created_at))
            end

            expect(invoice_1.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice_2.created_at.strftime("%A, %B %d, %Y"))
            expect(invoice_2.created_at.strftime("%A, %B %d, %Y")).to_not appear_before(invoice_1.created_at.strftime("%A, %B %d, %Y"))
        end
    end
end