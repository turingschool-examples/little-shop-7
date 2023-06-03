require "rails_helper"

RSpec.describe "Admin Invoices Show Page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer2.id)
  end

  describe "As an admin" do
    it "displays information for a single invoice" do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Invoice #{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Created on: #{@invoice_1.formatted_time}")
      expect(page).to have_content("Customer: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
    end
  end
end