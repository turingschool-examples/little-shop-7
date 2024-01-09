require 'rails_helper'

RSpec.describe "admin/invoices/show_spec.rb", type: :feature do
  describe "User Story 33" do
    # As an admin,
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    # Then I see information related to that invoice including:

    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name

    it "displays information about a given invoice" do
      invoice = create(:invoice)

      visit admin_invoice_path(invoice)

      expect(page).to have_content(invoice.id)
      expect(page).to have_content(invoice.status)
      expect(page).to have_content(invoice.format_created_date)
      expect(page).to have_content(invoice.customer.first_name)
      expect(page).to have_content(invoice.customer.last_name)
    end
  end
  
  describe "User Story 34" do
    # As an admin
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    # Then I see all of the items on the invoice including:
    # - Item name
    # - The quantity of the item ordered
    # - The price the Item sold for
    # - The Invoice Item status

    it "displays item information associated with a given invoice" do
      invoice = create(:invoice)
      item = create(:item)
      invoice_item = create(:invoice_item, invoice: invoice, item: item)
      
      visit admin_invoice_path(invoice)

      expect(page).to have_content(item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(invoice_item.unit_price)
      expect(page).to have_content(invoice_item.status)
    end
  end

  describe "User Story 35" do
    # As an admin
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    # Then I see the total revenue that will be generated from this invoice.
  
    it "displays the total item revenue of a given invoice" do
      item_1 = create(:item, unit_price: 1)
      item_2 = create(:item, unit_price: 2)
      item_3 = create(:item, unit_price: 3)
      
      invoice = create(:invoice)
      
      invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice, item: item_1)
      invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice, item: item_2)
      invoice_item_3 = create(:invoice_item, quantity: 1, invoice: invoice, item: item_3)
      
      visit admin_invoice_path(invoice)
      
      expect(page).to have_content(invoice.total_revenue)
    end
  end
  
  describe "User Story 36" do
    # As an admin     
    # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
    # I see the invoice status is a select field
    # And I see that the invoice's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Invoice,
    # And next to the select field I see a button to "Update Invoice Status"
    # When I click this button
    # I am taken back to the admin invoice show page
    # And I see that my Invoice's status has now been updated
    
    it "adds the functionality to update the invoice's status" do
      item = create(:item)
      invoice = create(:invoice, status: :cancelled)

      visit admin_invoice_path(invoice)

      expect(page).to have_content(invoice.status)
      expect(page).to have_select("invoice_status", with_options: ["in progress", "completed", "cancelled"])
      expect(page).to have_button("Update Invoice")
      select("completed", from: "invoice[status]")
      click_button("Update Invoice")
      
      expect(page).to have_button("Update Invoice")
      expect(page).to have_content("completed")
    end

  end

end