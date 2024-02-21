require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe "Associations" do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe "class methods" do

    before(:each) do
      @customers = create_list(:customer, 10)
    end

    describe "#top_five_customers" do
      it "returns the top 5 customers with the most successful transactions" do
        @customers.each do |customer| 
          customer.transactions.last.delete if @customers.index(customer) > 4
        end

        expect(Customer.top_five_customers).to eq([@customers[0], @customers[1], @customers[2], @customers[3], @customers[4]])
      end
    end
  end

  describe "instance methods" do
    before(:each) do
      @customers = create_list(:customer, 10)
    end

    describe "#successful_transactions_count" do
      it "returns the correct sum of successful transactions per customer" do
        @customers.each do |customer| 
          customer.transactions.last.delete if @customers.index(customer) > 4
        end

        expect(@customers.first.successful_transactions_count).to eq(15)
        expect(@customers.last.successful_transactions_count).to eq(14)
      end
    end
  end
end
