require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:credit_card_expiration_date) }
    it { should validate_presence_of(:result) }
  end

  describe "associations" do
    it { should belong_to(:invoice) }
  end

  describe "enums" do
    it "has an enum" do
      bob = Customer.create!(first_name: "Bob", last_name: "Smith")
      invoice1 = bob.invoices.create!(status: 0)
      transaction1 = invoice1.transactions.create!(credit_card_number: "1234567854", credit_card_expiration_date: "12/20", result: 0)
      transaction2 = invoice1.transactions.create!(credit_card_number: "12367854", credit_card_expiration_date: "12/23", result: 1)

      expect(transaction1.success?).to be true
      expect(transaction2.failed?).to be true
    end
  end
end
