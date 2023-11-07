require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end


  describe '#popular_items' do
    before :each do
      test_data_2
    end
    it 'list popular items ordered by revenue' do
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
end