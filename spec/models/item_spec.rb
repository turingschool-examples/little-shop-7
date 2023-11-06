require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:description)}
  end

  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, unit_price: 1234, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item_1, unit_price: 50000)
    @transaction_1 = create_list(:transaction, 5, result: 0)
  end

  describe "instance methods" do
    describe "#format_price" do
      it "returns unit price formatted as dollars and cents" do
        expect(@item_1.format_price).to eq("$12.34")
      end
    end

    describe "#created_format" do
      xit "returns created date formated as weekday, month day, year" do
        expect(@item_1.created_format).to eq("Sunday, November 05, 2023")
      end
    end

    describe "#total_revenue" do
      it "returns the total revenue from completed tranactions for an item" do
        expect(@item_1.total_revenue).to eq(250000)
      end
    end
  end
end