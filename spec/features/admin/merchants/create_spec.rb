require 'rails_helper'

RSpec.describe 'Admin merchants create page' do
    describe 'user story 29' do
        it 'has a form to create a new merchant' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            visit '/admin/merchants'

            click_on 'Create Merchant'

            # checks for form on page
            expect(page).to have_selector('form')
            expect(page).to have_button('Submit')
        end

        it 'can create a new merchant and redirect to index with new merch disabled' do
            odell = Merchant.create!(name: "Odell")
            nico = Merchant.create!(name: "Nico")

            visit '/admin/merchants'

            click_on 'Create Merchant'

            fill_in 'Name', with: 'Merchant Name'

            click_on 'Submit'

            # within new merchant?
            expect(page).to have_content("Merchant Name")
            # expect(page).to have_content("disabled")
        end

        it 'displays an error flash message when merchant creation fails' do

            visit '/admin/merchants/new'
      
            click_on 'Submit'

            expect(page).to have_content("Error. Please enter a name.")
        end
    end
end