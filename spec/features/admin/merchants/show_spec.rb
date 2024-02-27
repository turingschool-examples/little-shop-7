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

    describe "User Story 26" do
        it "shows a link to take me to admin merchant edit page where I see a form to change the merchant's information,
            after I click submit, I am redirected back to the merchant's admin show page where I see the updated information
            and a flash message stating that the information has been successfully updated" do

            merchant = FactoryBot.create(:merchant)

            visit admin_merchant_path(merchant)

            expect(page).to have_link("Edit Merchant Information", href: edit_admin_merchant_path(merchant))
            click_on "Edit Merchant Information"

            expect(page).to have_current_path(edit_admin_merchant_path(merchant))

            fill_in "Name", with: "Hoa"
            click_on "Submit"

            expect(page).to have_current_path(admin_merchant_path(merchant))
            expect(page).to have_content("Merchant information is updated successfully")
            expect(page).to have_content("Hoa")
            expect(page).not_to have_content("Odell")
        end
    end
end
