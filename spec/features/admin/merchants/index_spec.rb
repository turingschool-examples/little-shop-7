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
end
