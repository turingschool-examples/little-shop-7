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

    describe 'User story 29' do
        it 'has a link to merchant create page' do
            # I see a link to create a new merchant
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            visit '/admin/merchants'

            expect(page).to have_link('Create Merchant', href: '/admin/merchants/new')

            click_on 'Create Merchant'

            expect(current_path).to eq('/admin/merchants/new')
        end
    end

    describe 'User story 27' do
        it 'has a button to enable/disable next to each merchant' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            visit '/admin/merchants'

            save_and_open_page

            # 'Enable' initially appears because all merchants are disabled
            expect(page).to have_button("Enable")

            click_on 'Enable'

            expect(page).to have_button("Disable")
        end

        it 'changes merchant status and redirects to admin merch index' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            visit '/admin/merchants'

            click_on 'Enable'

            expect(current_path).to eq("/admin/merchants")
        end
    end
end