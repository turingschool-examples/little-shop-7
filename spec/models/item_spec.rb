require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "associations" do
    it { should belong_to :merchant }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through :invoice_items }
  end

  describe "enums" do
    it "has an enum for status" do
      merchant = Merchant.create!(name: "Test Merchant")
      item1 = merchant.items.create!(name: "Test Item 1", description: "Test Description 1", unit_price: 100, status: 0)
      item2 = merchant.items.create!(name: "Test Item 2", description: "Test Description 2", unit_price: 200, status: 1)
      
      expect(item1.enabled?).to be true
      expect(item2.disabled?).to be true
    end
  end

  describe "model methods" do
    it "has a top selling date method for an item" do
      merchant_1 = Merchant.create!(name: "Walmart")
      customer1 = Customer.create!(first_name: "John", last_name: "Smith")
      customer2 = Customer.create!(first_name: "Jane", last_name: "Sornes")
      customer3 = Customer.create!(first_name: "Jaques", last_name: "Snipes")
      item1 = merchant_1.items.create!(name: "popcan", description: "fun", unit_price: 10)
      item2 = merchant_1.items.create!(name: "popper", description: "fun", unit_price: 10)
      item3 = merchant_1.items.create!(name: "zipper", description: "pants", unit_price: 10)
      invoice1 = customer1.invoices.create!(created_at: Time.new(2018, 1, 1), status:2)
      invoice2 = customer2.invoices.create!(created_at: Time.new(2018, 2, 2), status: 2)
      invoice3 = customer3.invoices.create!(created_at: Time.new(2018, 3, 3), status: 2)
      invoice_item1 = invoice1.invoice_items.create!(item_id: item1.id, quantity: 1, unit_price: 10, status: 2)
      invoice_item2 = invoice1.invoice_items.create!(item_id: item2.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item3 = invoice1.invoice_items.create!(item_id: item3.id, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = invoice2.invoice_items.create!(item_id: item1.id, quantity: 2, unit_price: 10, status: 2)
      invoice_item5 = invoice2.invoice_items.create!(item_id: item2.id, quantity: 1, unit_price: 3, status: 2)
      invoice_item6 = invoice2.invoice_items.create!(item_id: item3.id, quantity: 2, unit_price: 10, status: 2)
      
      expect(item1.top_sales_date).to eq("February 02, 2018")
      expect(item2.top_sales_date).to eq("January 01, 2018")
    end
  end

end
