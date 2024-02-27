require 'rails_helper'

RSpec.describe 'Admin merchants index' do
    describe 'User story 24' do
        it 'shows the name of each merchant' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")
            # As an admin,
            # When I visit the admin merchants index (/admin/merchants)
            visit admin_merchants_path
            # Then I see the name of each merchant in the system
            expect(page).to have_content("Nico")
            expect(page).to have_content("Odell")
        end
    end

    describe 'User story 25 part 1' do
        it 'links merchant name to show page' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
            visit admin_merchants_path

            expect(page).to have_link("Odell")
            expect(page).to have_link("Nico")
            # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
            click_link "Odell"
            expect(current_path).to eq(admin_merchant_path(odell))

            visit admin_merchants_path

            click_link "Nico"
            expect(current_path).to eq(admin_merchant_path(nico))
            # And I see the name of that merchant
        end
    end

    describe 'User Story 27' do
        it "shows a button to disable or enable that merchant, when I click this button, the status has changed" do
            odell = Merchant.create!(name: "Odell", status: 0)
            nico = Merchant.create!(name: "Nico", status: 1)

            visit admin_merchants_path

            within "##{odell.id}" do
                click_on "Enable"
            end
            save_and_open_page
            expect(page).to have_button('Disable')
            expect(page).to have_content('Merchant status is updated successfully')

            within "##{nico.id}" do
                click_on "Disable"
            end
            expect(page).to have_button('Enable')
            expect(page).to have_content('Merchant status is updated successfully')
        end
    end

    describe 'User Story 30' do
        it "shows the names of the top 5 merchants by total revenue generated with the link to admin merchant show page" do
            top_merchants = create_list(:merchant, 5)
            top_merchants.each do |top_merchant|
                items = create_list(:item, 3, merchant: top_merchant)
                items.each do |item|
                    invoice = create(:invoice)
                    transaction = create(:transaction, invoice: invoice, result: 'success')
                    invoice_items = create(:invoice_item, item: item, invoice: invoice, quantity: 3, unit_price: 10)
                end
            end

            merchants = create_list(:merchant, 5)
            merchants.each do |merchant|
                items = create_list(:item, 3, merchant: merchant)
                items.each do |item|
                    invoice = create(:invoice)
                    transaction = create(:transaction, invoice: invoice, result: 'success')
                    invoice_items = create(:invoice_item, item: item, invoice: invoice, quantity: 1, unit_price: 10)
                end
            end

            visit admin_merchants_path

            top_merchants.each do |top_merchant|
                within "#top_merchant-#{top_merchant.id}" do
                    expect(page).to have_link(top_merchant.name, href: admin_merchant_path(top_merchant))
                    expect(page).to have_content("Total Revenue: $#{top_merchant.total_revenue}.00")
                end
            end
        end
    end
end
