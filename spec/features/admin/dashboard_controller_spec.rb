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
  it 'When I visit the admin dashboard' do
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit "/admin/"
    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link('Merchants', href: admin_merchants_path)
    # And I see a link to the admin invoices index (/admin/invoices)
    expect(page).to have_link('Invoices', href: admin_invoices_path)
  end
end
