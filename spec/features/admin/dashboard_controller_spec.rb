require "rails_helper"

RSpec.describe "the admin dashboard show" do
  
  # 19. Admin Dashboard
  it "displays the header" do
    # As an admin
    # When I visit the admin dashboard (/admin)
    visit "/admin/"
    # Then I see a header indicating that I am on the admin dashboard
    expect(page).to have_content("Admin Dashboard")
  end

  # 20. Admin Dashboard Links
  it 'has all necessary elements' do
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_dashboard_path
    
    expect(page).to have_selector('h1', text: 'Little Esty Shop')
    expect(page).to have_selector('h1', text: 'Admin Dashboard')

    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link('Merchants', href: admin_merchants_path)
    # And I see a link to the admin invoices index (/admin/invoices)
    expect(page).to have_link('Invoices', href: admin_invoices_path)
  end

  it 'displays the "top customers" and "incomplete invoices" dashboard sections' do
    
    visit admin_dashboard_path
    within('.incomplete-invoices') do
      expect(page).to have_selector('h2', text: 'Incomplete Invoices')
      #expect(page).to have_selector('ul', text: 'Under Construction')
    end
    within('.top-customers') do
      expect(page).to have_selector('h2', text: 'Top Customers')
      #expect(page).to have_selector('ol', text: 'Under Construction')
    end
  end
end
