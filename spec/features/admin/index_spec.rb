require "rails_helper"

RSpec.describe "/admin", type: :feature do
  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }
  let!(:customer_3) { create(:customer) }
  let!(:customer_4) { create(:customer) }
  let!(:customer_5) { create(:customer) }
  let!(:customer_6) { create(:customer) }

  let!(:invoice_1) { create(:invoice, customer_id: customer_1.id) }
  let!(:invoice_2) { create(:invoice, customer_id: customer_1.id) }
  let!(:invoice_3) { create(:invoice, customer_id: customer_1.id) }
  let!(:invoice_4) { create(:invoice, customer_id: customer_1.id) }
  let!(:invoice_5) { create(:invoice, customer_id: customer_1.id) }
  let!(:invoice_6) { create(:invoice, customer_id: customer_1.id) }

  let!(:trans_1) { create_list(:transaction, 10, invoice_id: invoice_1.id) }
  describe "admin dashboard" do
    it "will display a header indicating you are on the dashboard" do
      visit admin_path
      
      expect(page).to have_content("Admin Dashboard")
    end
    
    it "should display links to admin/merchants, admin/invoices, and admin/dashboard" do
      visit admin_path
      
      expect(page).to have_link("Dashboard", :href => admin_path)
      expect(page).to have_link("Merchants", :href => admin_merchants_path)
      expect(page).to have_link("Invoices", :href => admin_invoices_path)
    end
  end
end
#save_and_open_page
