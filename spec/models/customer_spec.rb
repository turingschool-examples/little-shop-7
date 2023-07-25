require "rails_helper"

RSpec.describe Customer, type: :model do
  before(:each) do
    test_data
  end
  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe "#test_data" do
    it "should have testable objects" do
      expect(@customer_1.first_name).to eq("Joey")
      expect(@invoice_item_1.item_id).to eq(539)
      expect(@invoice_1.status).to eq("cancelled")
      expect(@item_1.name).to eq("Item Qui Esse")
      expect(@merchant_1.name).to eq("Schroeder-Jerde")
      expect(@transaction_1.credit_card_number).to eq("4654405418249632")
    end
  end
end
