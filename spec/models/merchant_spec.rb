require "rails_helper"

RSpec.describe Merchant, type: :model do

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe '#top_5_customers_from_transactions' do
    it 'will list top 5 customers based on item purchases through invoices' do
      test_data
      expected_order = [@customer1, @customer2, @customer3, @customer4, @customer5]
      expect(@merchant1.top_5_customers_from_transactions).to eq(expected_order)
    end
  end

  describe '#popular_items' do
    it 'list popular items ordered by revenue' do
      test_data_2
      expect(@merchant1.popular_items).to eq([@item4, @item3, @item2, @item1, @item7])
    end
  end

end