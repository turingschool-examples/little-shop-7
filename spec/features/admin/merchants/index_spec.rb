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
            expect(current_path).to eq("/admin/merchants/#{odell.id}")    

            visit admin_merchants_path
            
            click_link "Nico"
            expect(current_path).to eq("/admin/merchants/#{nico.id}")
            # And I see the name of that merchant
        end
    end
end