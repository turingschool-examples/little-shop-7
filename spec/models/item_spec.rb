require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe "#instance_methods" do
    describe "#formatted_unit_prce" do
      it "converts unit_price in cents to dollars" do
        item = Item.new(name: "Ball", description: "round", unit_price: 75106)

        formatted_price = item.formatted_unit_price

        expect(formatted_price).to eq("$751.06")
      end
    end
  end

  describe "#disabled?" do
    it "checks to see if the status of an item is disabled" do
      item = Item.new(name: "Ball", description: "round", unit_price: 75106, status: 0)
      item_2 = Item.new(name: "Ball", description: "round", unit_price: 75106, status: 1)

      expect(item.disabled?).to eq(true)
      expect(item_2.disabled?).to eq(false)
    end
  end

  describe "#enabled?" do
    it "checks to see if the status of an item is enabled" do
      item = Item.new(name: "Ball", description: "round", unit_price: 75106, status: 0)
      item_2 = Item.new(name: "Ball", description: "round", unit_price: 75106, status: 1)

      expect(item.enabled?).to eq(false)
      expect(item_2.enabled?).to eq(true)
    end
  end
end