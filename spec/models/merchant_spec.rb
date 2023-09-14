require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "top 5 customers" do
    before (:each) do
      load_test_data
    end

    it "does something" do
      expect(@customer_1.invoices).to eq("")
    end
  end
end