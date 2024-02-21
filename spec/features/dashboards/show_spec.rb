require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
  let!(:merchant_1) { Merchant.create!(name: "John Doe")}
  describe "As a merchant" do
    it "shows the name of my merchant" do
      visit merchant_dashboard_path(merchant_id: merchant_1.id)

      expect(page).to have_content(merchant_1.name)
    end

    it "shows link to my merchant item index and merchant invoices index" do
      visit merchant_dashboard_path(merchant_id: merchant_1.id)

      expect(page).to have_link("My Items", href: merchant_items_path(merchant_1))
      expect(page).to have_link("My Invoices", href: merchant_invoices_path(merchant_1))
    end
  end
end
