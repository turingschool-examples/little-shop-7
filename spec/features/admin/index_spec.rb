require 'rails_helper'

RSpec.describe 'Admin dashboard' do
    let(:merchant) { FactoryBot.create(:merchant) }
    let(:item) { FactoryBot.create(:item, merchant: merchant) }
    let(:top_customers) { FactoryBot.create_list(:customer, 5) }
    let(:customers) { FactoryBot.create_list(:customer, 5) }

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
end