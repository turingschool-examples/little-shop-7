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
  end

  describe "instance methods" do
    describe "#format_price" do
      it "returns unit price formatted as dollars and cents" do
        expect(@item_1.format_price).to eq("$12.34")
      end
    end
  end
end