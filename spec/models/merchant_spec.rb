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
    xit 'enums tests' do
    end
  end

  describe '#instance methods' do 
    it "#top_five_cust" do 
      customers = [@cust_1, @cust_2, @cust_3, @cust_4, @cust_5]

      top_5 = @merch_1.top_five_cust.map { |cust| Customer.find(cust.id) }

      expect(top_5).to eq(customers)
    end

    it "#not_shipped_invoices" do
      expect(@merch_1.not_shipped_invoices).to eq(@invoice_6.invoice_items)
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
end
