  require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions}
  end

  describe "class methods" do
    it "#incomplete_invoices" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)
      invoices = Array.new
      invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_1))
      invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_2))
      
      invoices[0..1].each do |invoice|
        item = create(:item, merchant: merchant)
        invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 0)
      end
      invoices[2..3].each do |invoice|
        item = create(:item, merchant: merchant)
        invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 1)
      end
      invoices[4..5].each do |invoice|
        item = create(:item, merchant: merchant)
        invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 2)
      end
      expect(Invoice.incomplete_invoices).to eq([invoices[2],invoices[3],invoices[4],invoices[5]])
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
  
      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_1)
      @invoice_3 = create(:invoice, customer: @customer_1)
      @invoice_4 = create(:invoice, customer: @customer_2)
      @invoice_5 = create(:invoice, customer: @customer_2)
  
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
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
    end
    it "#revenue" do
      expect(@invoice_1.revenue).to eq(7000)
      expect(@invoice_2.revenue).to eq(6000)
    end
  end
end