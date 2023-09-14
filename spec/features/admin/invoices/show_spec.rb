require "rails_helper"

RSpec.describe "the admin invoices show page" do
  describe "US33 When I visit an admin invoice show page" do
    it "I see information related to that invoice including: id, status, created_at date in the format Monday, July 18, 2019, and customer first and last name" do
      customer = Customer.create!(
        first_name: "Vitalik",
        last_name: "Buterin"
      )
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)

      visit "/admin/invoices/#{invoice1.id}"

      save_and_open_page

      expect(page).to have_content(invoice1.id)
      expect(page).to have_content(invoice1.status)
      expect(page).to have_content(invoice1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
    end
  end

  describe "US34 When I visit an admin invoice show page" do
    xit "I see all of the items on the invoice including: item name, quantity ordered, price item sold for and invoice item status" do
      customer = Customer.create!(
        first_name: "Vitalik",
        last_name: "Buterin"
      )
      invoice1 = customer.invoices.create!(status: "in progress")
      item1 = invoice1.items.create!
      item2 = invoice1.items.create!

      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.quantity)
      expect(page).to have_content(item1.price)
      expect(page).to have_content(item1.invoice_items.status)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item2.quantity)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item2.invoice_items.status)
    end
  end
end
