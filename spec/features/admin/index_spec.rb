require "rails_helper"

RSpec.describe "/admin", type: :feature do
  describe "admin dashboard" do
    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }

    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id) }
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id) }
    let!(:invoice_3) { create(:invoice, customer_id: customer_3.id) }
    let!(:invoice_4) { create(:invoice, customer_id: customer_4.id) }
    let!(:invoice_5) { create(:invoice, customer_id: customer_5.id) }
    let!(:invoice_6) { create(:invoice, customer_id: customer_6.id) }

    let!(:trans_1_s) { create_list(:transaction, 1, result: 1, invoice_id: invoice_1.id) }
    let!(:trans_2_s) { create_list(:transaction, 2, result: 1, invoice_id: invoice_2.id) }
    let!(:trans_3_s) { create_list(:transaction, 3, result: 1, invoice_id: invoice_3.id) }
    let!(:trans_4_s) { create_list(:transaction, 4, result: 1, invoice_id: invoice_4.id) }
    let!(:trans_5_s) { create_list(:transaction, 5, result: 1, invoice_id: invoice_5.id) }
    let!(:trans_6_f) { create_list(:transaction, 6, result: 0, invoice_id: invoice_6.id) }
  end

  it "will display a header indicating you are on the dashboard" do
    visit admin_index_path

    expect(page).to have_content("Admin Dashboard")
  end

  it "should display links to admin/merchants, admin/invoices, and admin/dashboard" do
    visit admin_index_path

    expect(page).to have_link("Dashboard", :href => admin_index_path)
    expect(page).to have_link("Merchants", :href => admin_merchants_path)
    expect(page).to have_link("Invoices", :href => admin_invoices_path)
  end

end