require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many :items }
  end

  describe "factory_bot" do
    it "exists" do
      merchant = build(:merchant, name: "Apple")
      expect(merchant.name).to eq("Apple")
    end
  end
end