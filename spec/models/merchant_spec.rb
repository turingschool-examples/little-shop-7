require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe "#enabled?" do
    it "returns true or false depending on whether the @status of the Merchant is enabled or disabled" do
      merchant_1 = Merchant.create!(name: "Marco Polo", status: "enabled")
      expect(merchant_1.enabled?).to eq true

      merchant_2 = Merchant.create!(name: "Jeff Bezos", status: "disabled")

      expect(merchant_2.enabled?).to eq false
    end
  end
end
