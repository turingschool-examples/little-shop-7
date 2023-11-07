require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:description)}
  end

  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, unit_price: 1234, merchant: @merchant)
    @invoice_1 = create(:invoice)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 2, unit_price: 1234)
  end

  describe "instance methods" do
    describe "#format_price" do
      it "returns unit price formatted as dollars and cents" do
        expect(@item_1.format_price).to eq("$12.34")
      end
    end
    describe "#created_format" do
      it "returns created date formated as weekday, month day, year" do
        time = Time.new.in_time_zone("UTC")
      
        expect(@item_1.created_format).to eq(time.strftime("%A, %B %d, %Y"))
      end
    end
    describe "#price_total" do
      it "gives the sum of the quantity and cost" do
        expect(@item_1.price_total).to eq(2468)
      end
    end
  end
end