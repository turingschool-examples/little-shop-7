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

  describe "class methods" do
    it "#incomplete_invoices" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)
      invoices = Array.new
      invoices.concat(create_list(:invoice, 3, status: "completed", customer: customer_1))
      invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_2))
      
      invoices.each do |invoice|
        item = create(:item, merchant: merchant)
        invoice_item = create(:invoice_item, invoice: invoice, item: item)
      end
      expect(Invoice.incomplete_invoices).to eq([invoices[3],invoices[4],invoices[5]])
    end
  end
end