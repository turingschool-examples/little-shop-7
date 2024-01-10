require "rails_helper"

describe Customer, type: :model do
  before(:each) do 
    load_data
  end
  describe "relationships" do
    it { should have_many(:invoices) }
  end

  describe "class methods" do 
    describe "::top_customers_by_successful_transaction" do 
      it "returns the top five customers with the most transactions" do 
        expect(Customer.top_customers_by_successful_transaction).to match_array([@customers[4], @customers[7], @customers[1], @customers[3], @customers[5]])
      end
    end

    describe "::top_five_cust_per_merchant" do 
      it "returns the top five customers with the most transactions" do 
        expect(Customer.top_five_cust_per_merchant(@merchant.id)).to match_array([@customers[4], @customers[7], @customers[1], @customers[3], @customers[5]])
      end
    end
  end
end