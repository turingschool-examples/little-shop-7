require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe "relationships" do
    it { should belong_to :merchant}
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "factory_bot" do
    it "exists" do
      merchant = build(:merchant)
      item = build(:item, merchant: merchant, name: "The New Cool Thingy", description: "BUY NOW", unit_price: 1235)
      expect(item.merchant_id).to eq(merchant.id)
      expect(item.name).to eq("The New Cool Thingy")
      expect(item.description).to eq("BUY NOW")
      expect(item.unit_price).to eq(1235)
    end
  end
end