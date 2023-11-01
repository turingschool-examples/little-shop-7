require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant = create(:merchant)
    @customer_succ_1 = create(:customer)
    @customer_succ_2 = create(:customer)
    @customer_succ_3 = create(:customer)
    @customer_succ_4 = create(:customer)
    @customer_succ_5 = create(:customer)
    @customer_fail = create(:customer)
    @invoice_succ_1 = create(:invoice, customer: @customer_succ_1)
    @invoice_succ_2 = create(:invoice, customer: @customer_succ_2)
    @invoice_succ_3 = create(:invoice, customer: @customer_succ_3)
    @invoice_succ_4 = create(:invoice, customer: @customer_succ_4)
    @invoice_succ_5 = create(:invoice, customer: @customer_succ_5)
    @invoice_fail = create(:invoice, customer: @customer_fail)
    @items = create_list(:item, 20)
    @transactions_successful_1 = create_list(:transaction, 5, result: 0, invoice: @invoice_succ_1)
    @transactions_successful_2 = create_list(:transaction, 4, result: 0, invoice: @invoice_succ_2)
    @transactions_successful_3 = create_list(:transaction, 3, result: 0, invoice: @invoice_succ_3)
    @transactions_successful_4 = create_list(:transaction, 2, result: 0, invoice: @invoice_succ_4)
    @transactions_successful_5 = create_list(:transaction, 1, result: 0, invoice: @invoice_succ_5)
    @transactions_successful_5 = create_list(:transaction, 5, result: 1, invoice: @invoice_fail)
  end

  describe "instance methods" do
    describe "#top_customers" do
      it "returns a list of customers with largest number of successful transactions" do
        expect(@merchant.top_customers).to eq()
      end
    end
  end
end