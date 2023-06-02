require 'rails_helper'

RSpec.describe Item, type: :model do

  context "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  context "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  before(:each) do
    @merchant = create(:merchant)
    @item = create(:item, merchant_id: @merchant.id)
    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)
    @item3 = create(:item, merchant_id: @merchant.id)
    @item4 = create(:item, merchant_id: @merchant.id)

    @customer = create(:customer)
    @invoice = create(:invoice, customer_id: @customer.id)
    @invoice_item = create(:invoice_item, invoice_id: @invoice.id, item_id: @item.id)
    @transaction = create(:transaction, invoice_id: @invoice.id)
  end
end
