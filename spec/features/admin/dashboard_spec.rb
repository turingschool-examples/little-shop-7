require "rails_helper"

RSpec.describe "Admin Dashboard" do

  ## USER STORY 19
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end
  ## USER STORY 20
  it "when visiting the admin dashboard, it has a link for the admin merchants index" do
    visit "/admin"
    click_link("Admin Merchants Index")
    expect(current_path).to eq("/admin/merchants")
  end

  it "has a link for the admin invoices index" do
    visit "/admin"
    click_link("Admin Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end

  ## USER STORY 21
  it "when visiting the dashboard, the names of the top 5 customers with the largest number of successful transactions appears" do
    visit "/admin"
    # binding.pry
    # top_5_customers = 12
  end
end
