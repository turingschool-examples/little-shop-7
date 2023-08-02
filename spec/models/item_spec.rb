require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
    # it {should validate_presence_of :status}
    it { should allow_value(%w(true false)).for(:status) }
  end

  describe "relationships" do
    it { should belong_to :merchant}
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods" do
    it "can update status" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: true)

      item.update_status

      expect(item.status).to eq(false)

      item.update_status

      expect(item.status).to eq(true)
    end
  end

  describe "instance methods" do
    before :each do
      @merchant = create(:merchant)
    
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)
      @item_5 = create(:item, merchant: @merchant)

      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_2 = create(:invoice, customer: @customer_1, created_at: "2012-03-28 09:54:09 UTC")
      @invoice_3 = create(:invoice, customer: @customer_1, created_at: "2013-03-28 09:54:09 UTC")
      @invoice_4 = create(:invoice, customer: @customer_2, created_at: "2014-03-28 09:54:09 UTC")
      @invoice_5 = create(:invoice, customer: @customer_2, created_at: "2015-03-28 09:54:09 UTC")

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 2, quantity: 6, unit_price: 1000)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 2, quantity: 5, unit_price: 1000)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 4, unit_price: 1000)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, status: 2, quantity: 2, unit_price: 1000)
      @invoice_item_6 = create(:invoice_item, item: @item_5, invoice: @invoice_1, status: 2, quantity: 1, unit_price: 1000)
      @invoice_item_7 = create(:invoice_item, item: @item_4, invoice: @invoice_2, status: 2, quantity: 1, unit_price: 1000)
      @invoice_item_8 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 2, unit_price: 1000)
      @invoice_item_9 = create(:invoice_item, item: @item_2, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
      @invoice_item_10 = create(:invoice_item, item: @item_1, invoice: @invoice_5, status: 2, quantity: 4, unit_price: 1000)

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "failed")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "failed")
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: "failed")
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: "failed")
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
      @transaction_6 = create(:transaction, invoice: @invoice_1, result: "success")
      @transaction_7 = create(:transaction, invoice: @invoice_2, result: "success")
      @transaction_8 = create(:transaction, invoice: @invoice_3, result: "success")
      @transaction_9 = create(:transaction, invoice: @invoice_4, result: "success")
      @transaction_10 = create(:transaction, invoice: @invoice_5, result: "success")
    end
    it 'can find top selling date' do
      
      expect(@item_1.top_selling_date).to eq("March 25, 2012")
    end
  end
end