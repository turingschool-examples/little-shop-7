require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
  end


  describe "instance methods" do
    it "can find incomplete invoices" do
      customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
      invoice_1 = Invoice.create!(status: 0, customer: customer_1)  
      invoice_2 = Invoice.create!(status: 1, customer: customer_2)

      expect(Invoice.incomplete_invoices).to eq([invoice_1])
    end
  end
end
