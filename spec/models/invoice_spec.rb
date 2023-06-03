require 'rails_helper'

RSpec.describe Invoice, type: :model do

  context "relationship" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end

  context "validations" do
    it { should validate_presence_of :status}
  end

  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)

    @invoice_1 = create(:invoice, customer_id: @customer.id)
    @invoice_2 = create(:invoice, customer_id: @customer.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 1080, quantity: 2)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 267, quantity: 3)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_3.id, unit_price: 32, quantity: 1)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id, unit_price: 124, quantity: 1)
  end

  describe "instance methods" do
    describe "#revenue" do
      it "returns the total revenue for a single invoice" do
        expect(@invoice_1.revenue).to eq(2961)
        expect(@invoice_2.revenue).to eq(156)
      end
    end
  end
end
