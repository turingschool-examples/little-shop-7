require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many :items }
  end



  describe "instance methods" do
    describe "top_five_customers" do
      it "creates an array of 5 customers" do
        
        merchant = Merchant.first
        
        top_customers = merchant.top_five_customers
        #customer_names = top_customers.pluck(:name)
        require 'pry'; binding.pry
      end
    end
  end
end