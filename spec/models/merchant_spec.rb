require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
  end

  context "validations" do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, status: 0)
    @merchant_2 = create(:merchant, status: 0)
    @merchant_3 = create(:merchant, status: 1)
  end

  describe "#class methods" do
    it "can filter records by enabled" do
      original = [@merchant_1, @merchant_2, @merchant_3]
      expected = [@merchant_1, @merchant_2]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_enabled).to eq(expected)
    end

    it "can filter records by disabled" do
      original = [@merchant_1, @merchant_2, @merchant_3]
      expected = [@merchant_3]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_disabled).to eq(expected)
    end
  end
end
