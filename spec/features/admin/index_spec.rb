require 'rails_helper'

RSpec.describe 'Admin dashboard' do
    describe 'User story 19' do
        it 'displays admin dashboard header' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_index_path
            # Then I see a header indicating that I am on the admin dashboard
            expect(page).to have_content("Admin Dashboard")
        end
    end

    describe 'User story 20' do
        it 'displays admin dashboard links to merchant and invoice index' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit admin_index_path
            # Then I see a link to the admin merchants index (/admin/merchants)
            expect(page).to have_link("Merchants", href: "/admin/merchants")
            # And I see a link to the admin invoices index (/admin/invoices)
            expect(page).to have_link("Invoices", href: "/admin/invoices")
        end
    end
end