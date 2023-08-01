require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should allow_value(%w(true false)).for(:status) }
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "class methods" do
    it ".top_5_by_revenue" do
      merchants = create_list(:merchant, 10)
      
        successful_merchants = merchants[0..4]
        successful_merchants.each do |merchant|
          customer = create(:customer)
          item = create(:item, merchant: merchant)
          invoice = create(:invoice, customer: customer, status: "completed")
          create(:invoice_item, invoice: invoice, item: item, unit_price: 1000, quantity: rand(5..10), status: :shipped) # Total revenue: 50
        end
      expect(Merchant.top_5_by_revenue).to match_array(merchants[0..4])
      expect(Merchant.top_5_by_revenue).to_not match_array(merchants[4..9])
    end
  end

  describe "instance methods" do
    describe "Merchant Dashboard" do
      let!(:merchant) {create(:merchant)}
      let!(:item) {create(:item, merchant: merchant)}
      let!(:customer_1) {create(:customer)}
      let!(:customer_2) {create(:customer)}
      let!(:customer_3) {create(:customer)}
      let!(:customer_4) {create(:customer)}
      let!(:customer_5) {create(:customer)}
      let!(:customer_6) {create(:customer)}
      let!(:invoice_1) {create(:invoice, customer: customer_1)}
      let!(:invoice_2) {create(:invoice, customer: customer_2)}
      let!(:invoice_3) {create(:invoice, customer: customer_3)}
      let!(:invoice_4) {create(:invoice, customer: customer_4)}
      let!(:invoice_5) {create(:invoice, customer: customer_5)}
      let!(:invoice_6) {create(:invoice, customer: customer_6)}
      
      let!(:transaction_1) {create(:transaction, :success, invoice: invoice_1)}
      let!(:transaction_2) {create(:transaction, :success, invoice: invoice_2)}
      let!(:transaction_3) {create(:transaction, :success, invoice: invoice_3)}
      let!(:transaction_4) {create(:transaction, :success, invoice: invoice_4)}
      let!(:transaction_5) {create(:transaction, :success, invoice: invoice_5)}
      let!(:transaction_6) {create(:transaction, :success, invoice: invoice_6)}
      let!(:transaction_7) {create(:transaction, :success, invoice: invoice_1)}


      let!(:invoice_item_1) {create(:invoice_item, :shipped, item: item, invoice: invoice_1)}
      let!(:invoice_item_2) {create(:invoice_item, :shipped, item: item, invoice: invoice_2)}
      let!(:invoice_item_3) {create(:invoice_item, :shipped, item: item, invoice: invoice_3)}
      let!(:invoice_item_4) {create(:invoice_item, :shipped, item: item, invoice: invoice_4)}
      let!(:invoice_item_5) {create(:invoice_item, :shipped, item: item, invoice: invoice_5)}
      let!(:invoice_item_6) {create(:invoice_item, :shipped, item: item, invoice: invoice_6)}

      #User Story 3
      it "creates an array of 5 customers" do
        top_customers = merchant.top_five_customers

        #Method limits 5 customers
        expect(top_customers.length).to eq(5)
        #Only customer that has 2 transactions is the top customer
        expect(top_customers.first).to eq(customer_1)
        
      end

      #User Story 4 & 5
      describe "Items Ready to Ship" do
        let!(:item_2) {create(:item, merchant: merchant)}
        let!(:invoice_item_pending) {create(:invoice_item, :pending, item: item_2, invoice: invoice_1 )}
        let!(:invoice_item_pending_2) {create(:invoice_item, :pending, item: item_2, invoice: invoice_1 )}
        
        it "lists a name of all of all the merchants items that have status: packaged" do
          pending_packages = merchant.pending_items
          
          #An Array of packages that have the pending status only. 
          expect(pending_packages.length).to eq(2)
          expect(pending_packages.second.invoice_items.first.status).to eq("pending")
          #This will check that the invoice on :65 happens before the invoice on :66
          expect(pending_packages.first.invoice_items.first).to eq(invoice_item_pending)
        end


        describe "enabled_items & disabled_items" do
          before :each do
          @merchant = create(:merchant)
          @item_1 = create(:item, merchant: @merchant, status: true)
          @item_2 = create(:item, merchant: @merchant, status: false)
          @item_3 = create(:item, merchant: @merchant, status: true)
          @item_4 = create(:item, merchant: @merchant, status: false)
          @item_5 = create(:item, merchant: @merchant, status: true)
          @item_6 = create(:item, merchant: @merchant, status: false)
          @item_7 = create(:item, merchant: @merchant, status: true)
          @item_8 = create(:item, merchant: @merchant, status: false)
          end
          it "can list all enabled items" do
            @merchant.enabled_items

            expect(@merchant.enabled_items.length).to eq(4)
            expect(@merchant.enabled_items.first).to eq(@item_1)
            expect(@merchant.enabled_items.last).to eq(@item_7)
          end

          it "can list all disabled items" do
            @merchant.disabled_items

            expect(@merchant.disabled_items.length).to eq(4)
            expect(@merchant.disabled_items.first).to eq(@item_2)
            expect(@merchant.disabled_items.last).to eq(@item_8)
          end
        end

        describe "popular_items & revenue" do
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
          it "can list the top 5 items by revenue" do
            expect(@merchant.popular_items.length).to eq(5)
            expect(@merchant.popular_items.first).to eq(@item_1)
            expect(@merchant.popular_items.last).to eq(@item_5)
          end
        end
      end
    end

    it "#revenue" do
      merchants = create_list(:merchant, 10)
    
      successful_merchants = merchants[0..4]
      successful_merchants.each do |merchant|
        customer = create(:customer)
        item = create(:item, merchant: merchant)
        invoice = create(:invoice, customer: customer, status: "completed")
        create(:invoice_item, invoice: invoice, item: item, unit_price: 1000, quantity: 5, status: :shipped)
      end

      expect(successful_merchants.first.revenue).to eq(5000)
      expect(successful_merchants.last.revenue).to eq(5000)
      
      expect(merchants.last.revenue).to eq(0)
    end
  end
end