require "rails_helper"

RSpec.describe Invoice, type: :model do
  before :each do
    test_data
  end

  describe "relationships" do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end

  describe '#self.incomplete_not_shipped' do
    it 'will return invoices that are incomplete if any invoice items are packaged' do
      packaged_invoice = @incomplete
      expect(Invoice.incomplete_not_shipped.include?(packaged_invoice)).to eq(true)
    end

    it 'will return invoices that are incomplete if any invoice items are pending' do
      packaged_invoice = @incomplete2
      expect(Invoice.incomplete_not_shipped.include?(packaged_invoice)).to eq(true)
    end
  end
  
  describe "#format_date" do
    it "should return a new format for date created" do 
      test_invoice = create(:invoice, created_at: Time.new(2021, 3, 9))
      expect(test_invoice.format_date).to eq("Tuesday, March  9, 2021")
    end
  end 

  describe "#format_date" do
    it "should return a new format for date created" do 
      test_invoice = create(:invoice, created_at: Time.new(2021, 3, 9))
      expect(test_invoice.format_date).to eq("Tuesday, March  9, 2021")
    end
  end 

  describe "#total revenue" do
    it "should calculate total revenue for an invoice" do
      test_data_2
      expect(@invoice1.total_revenue).to eq(41417)
    end
  end 
end