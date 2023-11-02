require "rails_helper"

RSpec.describe "admin dashboard index page" do
  #user story 19
  it "Displays a admin dashboard header" do
    visit("/admin/dashboard")

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  #user story 20
  xit "has a link to the admin merchant index" do
    visit("/admin/dashboard")
    expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
    click_link("Admin Merchants")
    expect(current_path).to eq("/admin/merchants")
  end

  xit "has a link to the admin admin invoice index" do
    visit("/admin/dashboard")
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
    click_link("Admin Invoices")
    expect(page).to eq("/admin/invoices")
  end
end
