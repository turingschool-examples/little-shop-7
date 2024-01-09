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
      bob = Customer.create!(first_name: "Bob", last_name: "Smith")
      invoice1 = bob.invoices.create!(status: 0)
      invoice2 = bob.invoices.create!(status: 1)
      invoice3 = bob.invoices.create!(status: 2)

      expect(invoice1.in_progress?).to be true
      expect(invoice2.cancelled?).to be true
      expect(invoice3.completed?).to be true
    end
  end
end
