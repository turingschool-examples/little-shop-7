require 'rails_helper'

RSpec.describe 'Admin dashboard' do
    describe 'User story 19' do
        it 'displays admin dashboard header' do
            # As an admin,
            # When I visit the admin dashboard (/admin)
            visit "/admin"
            # Then I see a header indicating that I am on the admin dashboard
            expect(page).to have_content("Admin Dashboard")
        end
    end
end