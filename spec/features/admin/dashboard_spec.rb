require "rails_helper"

RSpec.describe "Admin Dashboard Page", type: :feature do
# US 19
  describe "When I visit the admin dashboard (/admin)" do
    it "I see a header indicating that I am on the admin dashboard" do

      visit admin_index_path
      within("#admin-dashboard-header") do
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end
# US 20
  it "can see a link to the admin merchants and invoices index" do

    visit admin_index_path

      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
  end
# US 22  
  it "can see a section for 'Incomplete Invoices'" do
    customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    invoice_1 = Invoice.create!(status: 0, customer: customer_1)  
    invoice_2 = Invoice.create!(status: 1, customer: customer_2)
    visit admin_index_path

    expect(page).to have_content("Incomplete Invoices")
  end
end
