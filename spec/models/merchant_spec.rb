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
    before :each do
      test_data_2
    end
    it 'list popular items ordered by revenue' do
      test_data_2
      expect(@merchant1.popular_items).to eq([@item4, @item3, @item2, @item1, @item7])
    end
  end

  describe '#popular_merchants' do
    before(:each) do
      test_data_joseph
    end
    
    it "returns the top 5 merchants based off revenue generated" do
      expect(Merchant.popular_merchants.sort).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant5])
    end
  end

  describe '#items_ready_to_ship_ordered_oldest_to_newest' do
    it 'list items ready to be shipped ordered by oldest to newest' do
      test_data_3
      expect(@merchant1.items_ready_to_ship_ordered_oldest_to_newest).to eq([
        {
          name: @item2.name,
          invoice_id: @invoice0.id,
          date: "Friday, January  1, 1999"
        },
        {
          name: @item3.name,
          invoice_id: @invoice0.id,
          date: "Friday, January  1, 1999"
        },
        {
          name: @item8.name,
          invoice_id: @invoice8.id,
          date: "Friday, August  8, 2008"
        }
      ])
    end
  end
end