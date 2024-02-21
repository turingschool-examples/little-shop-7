require 'rails_helper'

RSpec.describe 'Admin Dashboard (Index)', type: :feature do
  describe 'As an admin' do
    before(:each) do

    end

    #User Story 19
    it 'displays the admin dashboard header' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path
      
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")
    end

    #User Story 20. Admin Dashboard Links
    it 'displays links to admin merchants and invoices index' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path

      # Then I see a link to the admin merchants index (/admin/merchants)
      expect(page).to have_link(href: "/admin/merchants")

      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link(href: "/admin/invoices")
    end
  end
end