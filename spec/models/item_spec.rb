require 'rails_helper'

RSpec.describe Item, type: :model do

  context "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  context "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 0)}
  let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
  let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
  let!(:item_4) { create(:item, merchant_id: merchant_1.id, status: 0)}
  let!(:item_5) { create(:item, merchant_id: merchant_1.id, status: 1)}

  describe "class methods" do
    describe ".sort_enabled" do
      it "sorts the items by the enabled status" do
        expect(merchant_1.items.sort_enabled).to eq([item_2, item_3, item_5])
      end
    end

    describe ".sort_disabled" do
      it "sorts the items by disabled status" do
        expect(merchant_1.items.sort_disabled).to eq([item_1, item_4])
      end
    end
  end
end
