require "rails_helper"

RSpec.describe Invoice, type: :model do
  before :each do
    @date = DateTime.new(2012, 3, 10)
    @invoice1 = create(:invoice, created_at: @date) # automatically create associated customer, transactions and invoice_items
  end
  describe "relationships" do
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe "instance methods" do
    describe "#date_format" do
      it "can return the created_at date formatted as 'day_of_week, full_month padded_day, year'" do
        expect(@invoice1.date_format).to eq("Saturday, March 10, 2012")
      end
    end
  end
end