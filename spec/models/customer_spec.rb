require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { should have_many :invoices }
  end

  describe "class methods" do
    describe "top_5_spenders" do
      it "returns top 5 customers with most successful transactions" do
        customer_1 = create(:customer)
        customer_6 = create(:customer, first_name: "Not a Name", last_name: "Not a Last Name")
        customer_5 = create(:customer)
        customer_2 = create(:customer)
        customer_4 = create(:customer)
        customer_3 = create(:customer)

        top_5_customers = [customer_1, customer_2, customer_3, customer_4, customer_5]

        top_5_customers.each_with_index do |customer, index|
          invoice = create(:invoice, customer: customer)
          create_list(:transaction, 10 - index, invoice: invoice, result: 1)
        end

        invoice = create(:invoice, customer: customer_6)
        create_list(:transaction, 10, invoice: invoice, result: 0)
        create_list(:transaction, 5, invoice: invoice, result: 1)

        expect(Customer.top_5_spenders).to eq(top_5_customers)
      end
    end
  end
  
  describe "instance methods" do
    it "can display customer first and last name" do
      @customer = Customer.create(first_name: "John", last_name: "Doe")

      expect(@customer.full_name).to eq("John Doe")
    end
  end
end
