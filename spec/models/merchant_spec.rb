require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "top_five_customers" do 
    it "#top_five_customers" do 
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)

      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)

      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer: @customer_2)
      @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
      @transaction_3 = create(:transaction, result: "success", invoice: @invoice_2)

      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer: @customer_3)
      @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
      @transaction_4 = create(:transaction, result: "success", invoice: @invoice_3)
      @transaction_5 = create(:transaction, result: "success", invoice: @invoice_3)
      @transaction_6 = create(:transaction, result: "success", invoice: @invoice_3)

      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, customer: @customer_4)
      @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id)
      @transaction_7 = create(:transaction, result: "success", invoice: @invoice_4)
      @transaction_8 = create(:transaction, result: "success", invoice: @invoice_4)

      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, customer: @customer_5)
      @invoice_item_5 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id)
      @transaction_9 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_10 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_11 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_17 = create(:transaction, result: "success", invoice: @invoice_5)

      @customer_6 = create(:customer)
      @invoice_6 = create(:invoice, customer: @customer_6)
      @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)
      @transaction_12 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_13 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_14 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_15 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_16 = create(:transaction, result: "success", invoice: @invoice_6)
      
      top_custies = @merchant.top_five_customers.map { |customer| customer.first_name }

      expect(top_custies).to eq([@customer_6.first_name, @customer_5.first_name, @customer_3.first_name, @customer_4.first_name, @customer_2.first_name])
    end
  end
end