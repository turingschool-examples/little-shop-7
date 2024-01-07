require 'rails_helper'

RSpec.describe "admin/invoices/show_spec.rb", type: :feature do

  it "tests User Story 33: Admin Invoice Show Page" do
    # customer = create(:customer) # <----- don't even need this bit!
    invoice = create(:invoice)

    # As an admin,
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    visit admin_invoice_path(invoice)

    # Then I see information related to that invoice including:
    # Invoice id
    expect(page).to have_content(invoice.id)
    # Invoice status
    expect(page).to have_content(invoice.status)
    # Invoice created_at date in the format "Monday, July 18, 2019"
    expect(page).to have_content(invoice.format_created_at)
    # Customer first and last name
    expect(page).to have_content(invoice.customer.first_name)
    expect(page).to have_content(invoice.customer.last_name)
  end

end