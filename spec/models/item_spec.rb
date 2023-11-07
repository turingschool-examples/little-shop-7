require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:description)}
  end

  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, unit_price: 1234, merchant: @merchant)
    @invoice_1 = create(:invoice)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 2, unit_price: 1234)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_5)
    @invoice_6 = create(:invoice, customer: @customer_6)
    @item_1 = create(:item, merchant: @merchant, status: "enabled", unit_price: 1234)
    @item_2 = create(:item, merchant: @merchant, status: "enabled")
    @item_3 = create(:item, merchant: @merchant, status: "enabled")
    @item_4 = create(:item, merchant: @merchant, status: "disabled")
    @item_5 = create(:item, merchant: @merchant, status: "disabled")
    @item_6 = create(:item, merchant: @merchant, status: "disabled")
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, unit_price: 50000, quantity: 1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, unit_price: 40000)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3, unit_price: 30000)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4, unit_price: 20000)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5, unit_price: 10000)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, unit_price: 6000000, status: 2)
    @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
    @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
    @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
    @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
    @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
  end

  describe "instance methods" do
    describe "#format_price" do
      it "returns unit price formatted as dollars and cents" do
        expect(@item_1.format_price).to eq("$12.34")
      end
    end

    describe "#created_format" do
      it "returns created date formated as weekday, month day, year" do
        time = Time.new.in_time_zone("UTC")
      
        expect(@item_1.created_format).to eq(time.strftime("%A, %B %d, %Y"))
      end
    end

    describe "#price_total" do
      it "gives the sum of the quantity and cost" do
        expect(@item_1.price_total).to eq(2468)
      end
    end

    describe "#total_revenue" do
      it "returns the total revenue from completed tranactions for an item" do
        expect(@item_1.total_revenue).to eq(250_000)
      end
    end
  end
end