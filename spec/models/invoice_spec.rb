require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "associations" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "enums" do
    it "has an enum for status" do
      invoice1 = Invoice.create(status: 0)
      invoice2 = Invoice.create(status: 1)
      invoice3 = Invoice.create(status: 2)

      expect(invoice1.status).to eq("in_progress")
      expect(invoice2.status).to eq("cancelled")
      expect(invoice3.status).to eq("completed")
    end
  end
end
