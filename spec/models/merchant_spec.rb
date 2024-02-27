require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do 
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    
    @invoice_1 = create(:invoice, customer_id: @cust_1.id)
    @invoice_2 = create(:invoice, customer_id: @cust_2.id)
    @invoice_3 = create(:invoice, customer_id: @cust_3.id)
    @invoice_4 = create(:invoice, customer_id: @cust_4.id)
    @invoice_5 = create(:invoice, customer_id: @cust_5.id)
    @invoice_6 = create(:invoice, customer_id: @cust_6.id)
    
    @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_2 = create(:transaction, invoice_id: @invoice_2.id)
    @trans_3 = create(:transaction, invoice_id: @invoice_3.id)
    @trans_4 = create(:transaction, invoice_id: @invoice_4.id)
    @trans_5 = create(:transaction, invoice_id: @invoice_5.id)
    @trans_6 = create(:transaction, invoice_id: @invoice_6.id)
    
    @merch_1 = create(:merchant, name: "Amazon") 

    @item_1 = create(:item, unit_price: 1, merchant_id: @merch_1.id)

    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1, quantity: 100, status: 2)
    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: 1, quantity: 80, status: 2)
    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, unit_price: 1, quantity: 60, status: 2)
    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id, unit_price: 1, quantity: 50, status: 2)
    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id, unit_price: 1, quantity: 40, status: 2)
    create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id, unit_price: 1, quantity: 5)
  end 

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'Enums' do
    it 'enums tests' do
      should define_enum_for(:status).with_values(["disabled", "enabled"])
    end
  end

  describe '#instance methods' do 
    it "#top_five_customers" do 
      customers = [@cust_1, @cust_2, @cust_3, @cust_4, @cust_5]

      expect(@merch_1.top_five_cust).to eq(customers)
    end

    it "#not_shipped_invoices" do
      expect(@merch_1.not_shipped_invoices).to eq([@invoice_6])
    end

    describe '#enabled?' do
      it 'returns true or false depending on the status' do
        merch_1 = create(:merchant, name: "Amazon", status: 0)

        expect(merch_1.enabled?).to eq(false)

        merch_2 = create(:merchant, name: "Petco", status: 1) 

        expect(merch_2.enabled?).to eq(true)
      end
    end
  end

  before(:each) do
    @customer_11 = create(:customer)
    @customer_21 = create(:customer)
    @customer_31 = create(:customer)
    @customer_41 = create(:customer)
    @customer_51 = create(:customer)
    @customer_61 = create(:customer)

    @invoice_11 = create(:invoice, customer_id: @customer_11.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_21 = create(:invoice, customer_id: @customer_21.id, created_at: "Thurs, 22 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_31 = create(:invoice, customer_id: @customer_31.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_41 = create(:invoice, customer_id: @customer_41.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_51 = create(:invoice, customer_id: @customer_51.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_61 = create(:invoice, customer_id: @customer_61.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_71 = create(:invoice, customer_id: @customer_51.id, status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_81 = create(:invoice, customer_id: @customer_51.id, status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_91 = create(:invoice, customer_id: @customer_51.id, status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")

    @trans_11 = create(:transaction, invoice_id: @invoice_11.id)
    @trans_21 = create(:transaction, invoice_id: @invoice_11.id)
    @trans_31 = create(:transaction, invoice_id: @invoice_11.id)
    @trans_41 = create(:transaction, invoice_id: @invoice_11.id)
    @trans_51 = create(:transaction, invoice_id: @invoice_11.id)
    @trans_61 = create(:transaction, invoice_id: @invoice_21.id)
    @trans_71 = create(:transaction, invoice_id: @invoice_21.id)
    @trans_81 = create(:transaction, invoice_id: @invoice_21.id)
    @trans_91 = create(:transaction, invoice_id: @invoice_21.id)
    @trans_101 = create(:transaction, invoice_id: @invoice_31.id)
    @trans_111 = create(:transaction, invoice_id: @invoice_31.id)
    @trans_121 = create(:transaction, invoice_id: @invoice_31.id)
    @trans_131 = create(:transaction, invoice_id: @invoice_41.id)
    @trans_141 = create(:transaction, invoice_id: @invoice_41.id)
    @trans_151 = create(:transaction, invoice_id: @invoice_51.id)
    @trans_161 = create(:transaction, invoice_id: @invoice_61.id)
    @trans_171 = create(:transaction, invoice_id: @invoice_61.id, result: 1)
    @trans_181 = create(:transaction, invoice_id: @invoice_71.id)
    @trans_191 = create(:transaction, invoice_id: @invoice_81.id)
    @trans_201 = create(:transaction, invoice_id: @invoice_91.id, result: 1)
    
    @merchant_11 = create(:merchant, name: "Amazon", status: 0) 
    @merchant_21 = create(:merchant, name: "Walmart", status: 0) 
    @merchant_31 = create(:merchant, name: "Apple", status: 0) 
    @merchant_41 = create(:merchant, name: "Microsoft", status: 0) 
    @merchant_51 = create(:merchant, name: "Petco", status: 1) 
    @merchant_61 = create(:merchant, name: "Aetna", status: 1) 
    @merchant_71 = create(:merchant, name: "Adidas", status: 1) 

    @item_11 = create(:item, unit_price: 1, merchant_id: @merchant_11.id)
    @item_21 = create(:item, unit_price: 1, merchant_id: @merchant_11.id)
    @item_31 = create(:item, unit_price: 1, merchant_id: @merchant_11.id)
    @item_41 = create(:item, unit_price: 1, merchant_id: @merchant_11.id)
    @item_51 = create(:item, unit_price: 1, merchant_id: @merchant_21.id)
    @item_61 = create(:item, unit_price: 1, merchant_id: @merchant_21.id)
    @item_71 = create(:item, unit_price: 1, merchant_id: @merchant_31.id)
    @item_81 = create(:item, unit_price: 1, merchant_id: @merchant_41.id)
    @item_91 = create(:item, unit_price: 1, merchant_id: @merchant_51.id)
    @item_101 = create(:item, unit_price: 1, merchant_id: @merchant_61.id)

    @invoice_item_11 = create(:invoice_item, item_id: @item_11.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_21 = create(:invoice_item, item_id: @item_21.id, invoice_id: @invoice_21.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_31 = create(:invoice_item, item_id: @item_91.id, invoice_id: @invoice_31.id, quantity: 10, unit_price: 500, status: 1)
    @invoice_item_41 = create(:invoice_item, item_id: @item_101.id, invoice_id: @invoice_41.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item_51 = create(:invoice_item, item_id: @item_51.id, invoice_id: @invoice_51.id, quantity: 1, unit_price: 78000, status: 2)
    @invoice_item_61 = create(:invoice_item, item_id: @item_61.id, invoice_id: @invoice_71.id, quantity: 1, unit_price: 78000, status: 0)
    @invoice_item_71 = create(:invoice_item, item_id: @item_71.id, invoice_id: @invoice_81.id, quantity: 1, unit_price: 78000, status: 0)
    @invoice_item_81 = create(:invoice_item, item_id: @item_81.id, invoice_id: @invoice_91.id, quantity: 4, unit_price: 5500, status: 0)
  end

  describe '.class methods' do
    describe ".top_five_merchants" do
      it "returns an array of the 5 merchants with the highest revenue" do
        expect(Merchant.top_five_merchants).to eq([@merchant_21, @merchant_31, @merchant_51, @merchant_11, @merchant_61])
      end
    end
  end

  
  describe '#instance methods 2' do
    describe "#revenue_to_dollars" do
      it 'returns an integer with the pennies converted to dollars' do 
        expect(Merchant.top_five_merchants[0].revenue_to_dollars).to eq(1560)
      end
    end
    
    describe '#top_revenue_day' do
      it 'returns the date for the merchants highest revenue' do
        expect(@merchant_11.top_revenue_day).to eq("2024-02-22 00:47:11.096539 UTC")
        expect(@merchant_21.top_revenue_day).to eq("2024-02-21 00:47:11.096539 UTC")
        expect(@merchant_31.top_revenue_day).to eq("2024-02-20 00:47:11.096539 UTC")
        expect(@merchant_51.top_revenue_day).to eq("2024-02-21 00:47:11.096539 UTC")
        expect(@merchant_61.top_revenue_day).to eq("2024-02-21 00:47:11.096539 UTC")
      end
    end
  end  
end
