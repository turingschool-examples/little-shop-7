require "rails_helper"

RSpec.describe "/admin/invoices/:invoice_id" do
  describe "When I visit the admin invoices show page" do
    before do
      @merchant_1 = Merchant.create(name: "Merchant 1")
      @item_1 = Item.create!(name: "Bicycle", description: "It has 2 wheels and pedals.", unit_price: 500, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Boot", description: "Goes on foot.", unit_price: 500, merchant_id: @merchant_1.id)
      @customer_1 = Customer.create!(first_name: "Dan", last_name: "Smith")
      @customer_2 = Customer.create!(first_name: "Will", last_name: "Smoth")
      @invoice_1 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 25000, status: "shipped")
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 25000, status: "shipped")
    end

    it "has all items on an invoice with the invoice id, status, created at, and customer name" do
      visit "admin/invoices/#{@invoice_1.id}"
    end
  end
end