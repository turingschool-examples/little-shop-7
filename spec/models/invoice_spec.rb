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

  describe "#format_date" do
    it "should return a new format for date created" do 
      test_invoice = create(:invoice, created_at: Time.new(2021, 3, 9))
      expect(test_invoice.format_date).to eq("Tuesday, March  9, 2021")
    end
  end 

end