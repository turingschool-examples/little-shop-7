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

      #User Story 17
  describe "item_price" do
    before :each do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
        
      @item = create(:item, merchant:@merchant)
      @item2 = create(:item, merchant:@merchant)
      @item3 = create(:item, merchant:@merchant)
        
      
      @customer = create(:customer)
  
      @invoice = create(:invoice, customer: @customer)
        
      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice, status: 0, quantity: 1, unit_price: 800)

      @invoice_item2 = create(:invoice_item, item: @item, invoice: @invoice, status: 0,quantity: 1, unit_price: 800)

      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice, status: 0, quantity: 2, unit_price: 800)
        
    end
    it "sums unit price for all of the items listed under a invoice" do
      expect(@invoice.item_total_revenue).to eq(3200) 
    end
  end
end