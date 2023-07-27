require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "#formatted_unit_prce" do
    it "converts unit_price in cents to dollars" do
      item = Item.new(name: "Ball", description: "round", unit_price: 75106)

      formatted_price = item.formatted_unit_price

      expect(formatted_price).to eq("$751.06")
    end
  end
end