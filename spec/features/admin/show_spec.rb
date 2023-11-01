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
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
  end
end
