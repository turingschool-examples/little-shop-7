require 'rails_helper'

RSpec.describe 'Admin merchants show page' do
    describe 'User story 25 part 2' do
        it 'displays the name of the merchant' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")
            # As an admin,
            # When I visit the admin merchants index (/admin/merchants)
            visit admin_merchant_path(odell)
            # Then I see the name of each merchant in the system
            expect(page).to_not have_content("Nico")
            expect(page).to have_content("Odell")

            visit admin_merchant_path(nico)
            expect(page).to_not have_content("Odell")
            expect(page).to have_content("Nico")
        end
    end
end