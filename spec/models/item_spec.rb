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


end
