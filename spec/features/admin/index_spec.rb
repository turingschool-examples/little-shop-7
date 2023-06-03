require "rails_helper"

RSpec.describe "/admin", type: :feature do
  describe "admin dashboard" do
    let!(:merchant_1) { create(:merchant) }

    let!(:items_m1) { create_list(:item, 5, merchant_id: merchant_1.id) }

    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }
    let!(:customer_7) { create(:customer) }

    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id) }
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id) }
    let!(:invoice_3) { create(:invoice, customer_id: customer_3.id) }
    let!(:invoice_4) { create(:invoice, customer_id: customer_4.id) }
    let!(:invoice_5) { create(:invoice, customer_id: customer_5.id) }
    let!(:invoice_6) { create(:invoice, customer_id: customer_6.id) }
    let!(:invoice_7) { create(:invoice, customer_id: customer_7.id) }
    let!(:invoice_8) { create(:invoice, customer_id: customer_7.id) }

    let!(:invoice_item_1) { create(:invoice_item, invoice_id: invoice_7.id, item_id: items_m1[0].id, status: 1 ) }
    let!(:invoice_item_2) { create(:invoice_item, invoice_id: invoice_7.id, item_id: items_m1[1].id, status: 1 ) }
    let!(:invoice_item_3) { create(:invoice_item, invoice_id: invoice_7.id, item_id: items_m1[2].id, status: 0 ) }
    let!(:invoice_item_4) { create(:invoice_item, invoice_id: invoice_7.id, item_id: items_m1[3].id, status: 0 ) }
    let!(:invoice_item_5) { create(:invoice_item, invoice_id: invoice_7.id, item_id: items_m1[4].id, status: 2 ) }
    let!(:invoice_item_6) { create(:invoice_item, invoice_id: invoice_8.id, item_id: items_m1[4].id, status: 2 ) }

    let!(:trans_1_s) { create_list(:transaction, 1, result: 1, invoice_id: invoice_1.id) }
    let!(:trans_2_s) { create_list(:transaction, 2, result: 1, invoice_id: invoice_2.id) }
    let!(:trans_3_s) { create_list(:transaction, 3, result: 1, invoice_id: invoice_3.id) }
    let!(:trans_4_s) { create_list(:transaction, 4, result: 1, invoice_id: invoice_4.id) }
    let!(:trans_5_s) { create_list(:transaction, 5, result: 1, invoice_id: invoice_5.id) }
    let!(:trans_6_f) { create_list(:transaction, 6, result: 0, invoice_id: invoice_6.id) }

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

    it "should display top 5 customers by successful transactions" do
      visit admin_index_path

      within "#top-5-customers" do
        expect(page).to have_content("Top Customers")
        expect(customer_5.first_name).to appear_before(customer_4.first_name)
        expect(customer_4.first_name).to appear_before(customer_3.first_name)
        expect(customer_3.first_name).to appear_before(customer_2.first_name)
        expect(customer_2.first_name).to appear_before(customer_1.first_name)
        expect(page).to_not have_content(customer_6.first_name)
      end
    end

    it "should displays a section for incomplete invoices with ids as links" do
      visit admin_index_path
      
      within "#incomplete-invoices" do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content("Invoice ##{invoice_7.id}")
        expect(page).to have_link("#{invoice_7.id}", :href => admin_invoice_path(invoice_7))
        expect(page).to_not have_link("#{invoice_8.id}", :href => admin_invoice_path(invoice_8))
      end
    end
  end
end
