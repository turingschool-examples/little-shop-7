require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:credit_card_expiration_date) }
    it { should validate_presence_of(:result) }
  end

  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should have_many(:customers).through(:invoice) }
  end

  describe "factory_bot" do
    it "exists" do
      invoice = build(:invoice)
      transaction = build(:transaction, invoice: invoice, credit_card_number: "11111111111111111", result: "success")
      expect(transaction.invoice_id).to eq(invoice.id)
      expect(transaction.credit_card_number).to eq("11111111111111111")
      expect(transaction.credit_card_expiration_date).to eq("04/27")
      expect(transaction.result).to eq("success")
    end
  end
end