require "rails_helper"

RSpec.describe "the admin index" do
  it "displays a header at the top of the dashboard" do
    
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  
  end

  it "has links to the admin merchant's index and the admin invoices index" do
    visit "/admin"

    save_and_open_page

    within("#admin_merchants_index") do
      expect(page).to have_link("Merchants")
    end
    
    within("#admin_invoices_index") do
      expect(page).to have_link("Invoices")
    end
  end
end