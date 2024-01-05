require 'rails_helper'

RSpec.describe "admin/invoices/index_spec.rb", type: :feature do
  it "test User Story 32: Admin Invoices Index Page" do
    customers = create_list(:customer, 3)
    invoices = create_list(:invoice, 3)
    # As an admin, 
    # is there a way to test for this? Are there permissions?
    # When I visit the admin Invoices index (/admin/invoices)
    visit admin_invoices_path
    # require 'pry'; binding.pry
    # Then I see a list of all Invoice ids in the system
    Invoice.all.each do |invoice|
      expect(page).to have_content(invoice.id)
    # Each id links to the admin invoice show page
      expect(page).to have_link(href: admin_invoice_path(invoice))
    end
    # # Click link to confirm it works
    #   click_link(admin_invoice_path(invoice))
    # # Confirm that the link is to the correct path
    #   expect(current_path).to eq(admin_invoice_path(invoice))
  end
end