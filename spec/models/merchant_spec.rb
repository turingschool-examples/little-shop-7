require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do

    let!(:little_kin_shop) { create(:merchant) }
    let!(:red_roses) { create(:merchant) }
    let!(:halloween_face) { create(:merchant) }
    let!(:tall_boy) { create(:merchant, status: 1) }
    let!(:arleen) { create(:merchant, status: 1) }
    let!(:bust_it_big) { create(:merchant, status: 1) }

    describe ".enabled_merchants" do
      it "returns an array of enabled merchants" do
        expect(Merchant.enabled_merchants).to eq([little_kin_shop, red_roses, halloween_face])
      end
    end

    describe ".disabled_merchants" do
      it "returns an array of disabled merchants" do
        expect(Merchant.disabled_merchants).to eq([tall_boy, arleen, bust_it_big])
      end
    end
  end
end