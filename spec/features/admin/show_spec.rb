require "rails_helper"

RSpec.describe "admin dashboard index page" do
  it "Displays a admin dashboard header" do
    visit admin_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  #user story 20
  it "has a link to the admin merchant and admin invoice indecies" do
    visit admin_path

    expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
    click_link("Admin Merchants")
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
    click_link("Admin Invoices")
    expect(page).to eq(admin_invoice_path)
  end
end
