require "rails_helper"

RSpec.describe "the admin invoices index page" do
  describe "empty invoice index page" do
    it "can display a message when there are no invoices" do
      visit "/admin/invoices"

      expect(page).to have_content("No Invoices Found")
    end
  end

  describe "complete invoices list" do
    it "lists all invoice id's in the system" do
      customer = Customer.create!(
        first_name: "Satoshi",
        last_name: "Nakamoto"
      )
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)

      visit "/admin/invoices"

      expect(page).to have_link("#{invoice1.id}")
      expect(page).to have_link("#{invoice2.id}")
      expect(page).to have_link("#{invoice3.id}")
    end
  end
end
