require 'rails_helper'

RSpec.describe "admin/invoices/index_spec.rb", type: :feature do
  describe "User Story 32" do
    # As an admin,
    # When I visit the admin Invoices index (/admin/invoices)
    # Then I see a list of all Invoice ids in the system
    # Each id links to the admin invoice show page
    
    it "displays all admin invoices" do
      customers = create_list(:customer, 3)
      invoices = create_list(:invoice, 3)

      visit admin_invoices_path

      Invoice.all.each do |invoice|
        expect(page).to have_content(invoice.id)
        expect(page).to have_link(href: admin_invoice_path(invoice))
      end
    end

    it "overtests User Story 32" do
      # This require the actual creation of the show page to test the accuracy of the paths.
      # The above test was enough: I confirmed with Juliet.
      customer = create(:customer)
      invoice = create(:invoice)

      visit admin_invoices_path
    
      click_link(invoice.id.to_s)
      expect(current_path).to eq(admin_invoice_path(invoice))
    end
  end

end