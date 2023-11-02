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
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_5)
    @invoice_6 = create(:invoice, customer: @customer_6)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6)
    @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
    @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
    @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
    @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
    @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
  end

  describe "instance methods" do
    describe "#succ_transaction_count" do
      it "returns a count of successful transactions with a given merchant" do
        expect(@customer_1.succ_transaction_count(@merchant)).to eq(5)
      end
    end
  end

  describe "class methods" do
    describe ".top_five_customers" do
      it "returns a list of customers with largest number of successful transactions for a merchant" do
        expect(Customer.top_five_customers(@merchant)).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end

      it "only counts successful transactions" do
        expect(Customer.top_five_customers(@merchant)).to_not include(@customer_6)
      end
    end
  end
end
