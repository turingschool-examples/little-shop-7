require "rails_helper"

# Merchant Invoices Index
# As a merchant,
# When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page

RSpec.describe "the merchant's invoice index" do
  describe "empty invoice index page" do
    it "can display a message when there are no invoices" do
      visit "/admin/:merchant_id/invoices"

      expect(page).to have_content("No Invoices Found")
    end
  end

  describe "complete invoices list" do
    it "lists all invoice id's in the system" do
      customer = Customer.create!(
        first_name: "Satoshi",
        last_name: "Nakamoto"
      )
      invoice_1 = customer.invoices.create!(status: 0)
      invoice_2 = customer.invoices.create!(status: 1)
      invoice_3 = customer.invoices.create!(status: 2)

      visit "/admin/:merchant_id/invoices"

      expect(page).to have_link("#{invoice_1.id}")
      expect(page).to have_link("#{invoice_2.id}")
      expect(page).to have_link("#{invoice_3.id}")
    end
  end
end