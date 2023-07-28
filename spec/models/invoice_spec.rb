  require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions}
  end

  describe "factory_bot" do
    it "exists" do
      customer = build(:customer)
      invoice = create(:invoice, customer: customer, status: 1)
      expect(invoice.customer_id).to eq(customer.id)
      expect(invoice.status).to eq("in progress")
    end
  end
end