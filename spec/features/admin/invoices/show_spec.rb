require 'rails_helper'

RSpec.describe "admin/invoices/show_spec.rb", type: :feature do

  it "tests User Story 33: Admin Invoice Show Page" do
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
    expect(page).to have_content(invoice.format_created_date)
    # Customer first and last name
    expect(page).to have_content(invoice.customer.first_name)
    expect(page).to have_content(invoice.customer.last_name)
  end
  
  it "tests User Story 34:  Admin Invoice Show Page: Invoice Item Information" do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    
    # As an admin
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    visit admin_invoice_path(invoice)

    # Then I see all of the items on the invoice including:
    # - Item name
    expect(page).to have_content(item.name)
    # - The quantity of the item ordered
    expect(page).to have_content(invoice_item.quantity)
    # - The price the Item sold for
    expect(page).to have_content(invoice_item.unit_price)
    # - The Invoice Item status
    expect(page).to have_content(invoice_item.status)
  end

  it "tests User Story 35: Admin Invoice Show Page: Total Revenue" do
    item_1 = create(:item, unit_price: 1)
    item_2 = create(:item, unit_price: 2)
    item_3 = create(:item, unit_price: 3)
  
    invoice = create(:invoice)
  
    invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 1, invoice: invoice, item: item_3)
    
    # As an admin
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    visit admin_invoice_path(invoice)
    
    # Then I see the total revenue that will be generated from this invoice.
    expect(page).to have_content(invoice.total_revenue)
  end
end