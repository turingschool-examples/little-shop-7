require "rails_helper"

RSpec.describe "the admin invoices show page" do
  describe "When I visit an admin invoice show page" do
    it "I see information related to that invoice including: id, status, created_at date in the format Monday, July 18, 2019, and customer first and last name" do
      customer = Customer.create!(
        first_name: "Vitalik",
        last_name: "Buterin"
      )
      invoice1 = Customer.invoice.create!(status: 0)
      invoice2 = Customer.invoice.create!(status: 1)
      invoice3 = Customer.invoice.create!(status: 2)

      visit "/admin/invoices/#{invoice.id}"

      expect(page).to have_content(invoice.id)
      expect(page).to have_content(invoice.status)
      expect(page).to have_content(invoice.created_at)
      expect(page).to have_content("#{customer.first_name} + " " + #{customer.last_name}")
    end
  end
end
