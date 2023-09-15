require "rails_helper"

RSpec.describe "the admin invoices show page" do
  describe "US33 When I visit an admin invoice show page" do
    it "I see information related to that invoice including: id, status, created_at date in the format Monday, July 18, 2019, and customer first and last name" do
      customer = Customer.create!(
        first_name: "Vitalik",
        last_name: "Buterin"
      )
      invoice_1 = customer.invoices.create!(status: 0)
      invoice_2 = customer.invoices.create!(status: 1)
      invoice_3 = customer.invoices.create!(status: 2)

      visit "/admin/invoices/#{invoice1.id}"

      save_and_open_page

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
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
      item_1 = invoice1.items.create!
      item_2 = invoice1.items.create!

      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.quantity)
      expect(page).to have_content(item_1.price)
      expect(page).to have_content(item_1.invoice_items.status)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.quantity)
      expect(page).to have_content(item_2.price)
      expect(page).to have_content(item_2.invoice_items.status)
    end
  end
end
