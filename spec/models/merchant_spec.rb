require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @items = create_list(:item, 20, merchant: @merchant_1)

    # Create invoices with and associate with items
    @invoices = create_list(:invoice, 20)
    @invoice_items = @invoices.map do |invoice|
      create(:invoice_item, item: @items.sample, invoice: invoice)
    end

    # Create customers and associate them with random invoices
    @customers = create_list(:customer, 10)
    @invoices.each do |invoice|
      invoice.update(customer: @customers.sample)
    end

    @transactions = @invoices.map do |invoice|
      create(:transaction, invoice: invoice, result: 0)
    end
  end
  
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "#instance_methods" do
    describe "#top_5_customers" do
      it "can list the merchant's top 5 customers" do
        expect(@merchant_1.top_5_customers.count).to eq(5)
      end
    end 

    describe "#ready_to_ship" do
      it "can list items that are ready to ship and order items from oldest to newest" do
        ready_to_ship_invoice_items = @invoices.map do |invoice|
          create(:invoice_item, item: @items.sample, invoice: invoice, status: 1)
        end
        
        item_names = @merchant_1.ready_to_ship.each do |invoice_item|
          invoice_item.name
        end

        expect(@merchant_1.ready_to_ship).not_to be_empty
        expect(@merchant_1.ready_to_ship).to include(*item_names)
        
        # User Story 5
        created_dates = @merchant_1.ready_to_ship.map do |item|
          item.created_at
        end
        
        expect(created_dates).to eq(created_dates.sort)
      end
    end
  end
    
  describe "class methods" do

    let!(:little_kin_shop) { create(:merchant) }
    let!(:red_roses) { create(:merchant) }
    let!(:halloween_face) { create(:merchant) }
    let!(:tall_boy) { create(:merchant, status: 1) }
    let!(:arleen) { create(:merchant, status: 1) }
    let!(:bust_it_big) { create(:merchant, status: 1) }
    
    describe ".enabled_merchants" do
      it "returns an array of enabled merchants" do
        expect(Merchant.enabled_merchants).to eq([little_kin_shop, red_roses, halloween_face])
      end
    end
    
    describe ".disabled_merchants" do
      it "returns an array of disabled merchants" do
        expect(Merchant.disabled_merchants).to eq([tall_boy, arleen, bust_it_big])
      end
    end
  end
end