require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "#instance_methods" do
    describe "#format_created_at" do
      it "can format the created_at timestampt to resemble 'Monday, July 18, 2019'" do
        customer = Customer.create!(first_name: "Ringo", last_name: "Star")
        invoice = customer.invoices.create!(status: "completed", customer_id: 12345, created_at: 'Thu, 27 Jul 2023 21:03:33.548215000 UTC +00:00')

        expect(invoice.format_created_at).to eq('Thursday, July 27, 2023')
      end
    end
  end
end