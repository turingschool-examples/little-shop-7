require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
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
    @items_succ_1 = create_list(:item, 20, merchant: @merchant)
    @transactions_succ_1 = create_list(:transaction, 5, result: 0, invoice: @invoice_succ_1)
    @transactions_succ_2 = create_list(:transaction, 4, result: 0, invoice: @invoice_succ_2)
    @transactions_succ_3 = create_list(:transaction, 3, result: 0, invoice: @invoice_succ_3)
    @transactions_succ_4 = create_list(:transaction, 2, result: 0, invoice: @invoice_succ_4)
    @transactions_succ_5 = create_list(:transaction, 1, result: 0, invoice: @invoice_succ_5)
    @transactions_fail = create_list(:transaction, 5, result: 1, invoice: @invoice_fail)
  end

  describe "class methods" do
    describe ".top_customers" do
      it "returns a list of customers with largest number of successful transactions for a merchant" do
        require 'pry'; binding.pry
        expect(Customer.top_customers(@merchant)).to eq([@customer_succ_1, @customer_succ_2, @customer_succ_3, @customer_succ_4, @customer_succ_5])
      end
    end
  end
end