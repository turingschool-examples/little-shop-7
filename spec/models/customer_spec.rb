require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:items).through(:invoice_items)}
  end

  before(:each) do
    @customer_1 = create(:customer) # 6 successful transactions
    @customer_2 = create(:customer) # 5 successful transactions
    @customer_3 = create(:customer) # 4 successful transactions
    @customer_4 = create(:customer) # 3 successful transactions
    @customer_5 = create(:customer) # 2 successful transactions
    @customer_6 = create(:customer) # 1 successful transactions
    @customer_7 = create(:customer) # 0 successful transactions

    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_2.invoices.create!(status: 1)
    @invoice_3 = @customer_3.invoices.create!(status: 1)
    @invoice_4 = @customer_4.invoices.create!(status: 1)
    @invoice_5 = @customer_5.invoices.create!(status: 1)
    @invoice_6 = @customer_6.invoices.create!(status: 1)
    @invoice_7 = @customer_7.invoices.create!(status: 1)

    @transaction_1 = @invoice_1.transactions.create!(result: "success")
    @transaction_2 = @invoice_1.transactions.create!(result: "success")
    @transaction_3 = @invoice_1.transactions.create!(result: "success")
    @transaction_4 = @invoice_1.transactions.create!(result: "success")
    @transaction_5 = @invoice_1.transactions.create!(result: "success")
    @transaction_6 = @invoice_1.transactions.create!(result: "success")
    @transaction_7 = @invoice_2.transactions.create!(result: "success")
    @transaction_8 = @invoice_2.transactions.create!(result: "success")
    @transaction_9 = @invoice_2.transactions.create!(result: "success")
    @transaction_10 = @invoice_2.transactions.create!(result: "success")
    @transaction_11 = @invoice_2.transactions.create!(result: "success")
    @transaction_12 = @invoice_3.transactions.create!(result: "success")
    @transaction_13 = @invoice_3.transactions.create!(result: "success")
    @transaction_14 = @invoice_3.transactions.create!(result: "success")
    @transaction_15 = @invoice_3.transactions.create!(result: "success")
    @transaction_16 = @invoice_4.transactions.create!(result: "success")
    @transaction_17 = @invoice_4.transactions.create!(result: "success")
    @transaction_18 = @invoice_4.transactions.create!(result: "success")
    @transaction_19 = @invoice_5.transactions.create!(result: "success")
    @transaction_20 = @invoice_5.transactions.create!(result: "success")
    @transaction_21 = @invoice_6.transactions.create!(result: "success")
    @transaction_22 = @invoice_7.transactions.create!(result: "failed")
  end

  describe "Class Methods" do
    describe "#top_five_by_successful_transactions" do
      it "returns the five customers with the most successful transactions" do
        expect(Customer.top_five_by_successful_transactions).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end

  describe "Instance Methods" do
    describe "#num_successful_transactions" do
      it "counts the number of successful transactions for a customer" do
        expect(@customer_1.num_successful_transactions).to eq(6)
        expect(@customer_2.num_successful_transactions).to eq(5)
        expect(@customer_3.num_successful_transactions).to eq(4)
        expect(@customer_4.num_successful_transactions).to eq(3)
        expect(@customer_5.num_successful_transactions).to eq(2)
        expect(@customer_6.num_successful_transactions).to eq(1)
        expect(@customer_7.num_successful_transactions).to eq(0)
      end
    end
  end
end