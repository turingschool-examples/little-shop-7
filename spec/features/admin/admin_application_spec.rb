require "rails_helper"

RSpec.describe "admin dashboard" do
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    
    expect(page).to have_content("Welcome to the admin dashboard!")
  end

  xit "displays a link to the admin merchants index" do
    visit "/admin"

    expect(page).to have_link("Merchants")
    click_link("Merchants")
    expect(page).to have_current_path("/admin/merchants")
  end

  it "displays a link to the admin invoices index" do
    visit "/admin"

    expect(page).to have_link("Invoices")
    click_link("Invoices")
    expect(page).to have_current_path("/admin/invoices")
  end
end