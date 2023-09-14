require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "top 5 customers" do
    before (:each) do
      load_test_data
    end

    it "can display top customers" do
      expect(Merchant.top_customers.first.first_name).to eq("Frodo")
    end
  end
end