require "rails_helper"

RSpec.describe "Merchant Invoices Index Page" do
  before(:each) do
    @merchant = create(:merchant)

    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer1.id)
    @invoice_3 = create(:invoice, customer_id: @customer2.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_3.id)
  end

  describe "As a merchant" do
    it "I see all of my invoices on the index page" do
      visit "/merchants/#{@merchant.id}/invoices"

      expect(page).to have_content("My Invoices")
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
    end
  end
end