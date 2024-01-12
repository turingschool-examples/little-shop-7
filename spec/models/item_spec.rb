require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "class_methods" do 
    describe "::ready_to_ship" do 
      it "returns all of a merchant's items that haven't been shipped but are ready to ship" do 
        create_list(:invoice_item, 8, status: rand(0..1))
        merchant = create(:merchant)
        merchant.items = create_list(:item, 5)
        ship_ready = []
        shipped = []
  
        5.times do |n|
          ship_ready << create(:invoice_item, status: rand(0..1), item_id: merchant.items.sample.id)
        end
  
        5.times do |n|
          shipped << create(:invoice_item, status: 2, item_id: merchant.items.sample.id)
        end
        expect(merchant.items.ready_to_ship.pluck(:item_id)).to match_array(ship_ready.pluck(:item_id))
        expect(merchant.items.ready_to_ship.pluck(:item_id)).to_not match_array(shipped.pluck(:item_id))
      end
    end
    
    describe "::top_5_by_revenue" do 
      it "returns a merchant's top 5 items based on total revenue" do 
        @merchant = create(:merchant)
        @items = create_list(:item, 8, merchant_id: @merchant.id)
        @customers = create_list(:customer, 8)

        @invoice_1 = create(:invoice, status: rand(1..2), customer_id: @customers[5].id)
        @invoice_2 = create(:invoice, status: rand(1..2), customer_id: @customers[1].id)
        @invoice_3 = create(:invoice, status: rand(1..2), customer_id: @customers[2].id)
        @invoice_4 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id)
        @invoice_5 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id)
        @invoice_6 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id)
        @invoice_7 = create(:invoice, status: rand(1..2), customer_id: @customers[1].id)
        @invoice_8 = create(:invoice, status: rand(1..2), customer_id: @customers[0].id)
        @invoice_9 = create(:invoice, status: rand(1..2), customer_id: @customers[3].id)
        @invoice_10 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id)
        @invoice_11 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id)
        @invoice_12 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id)
        @invoice_13 = create(:invoice, status: rand(1..2), customer_id: @customers[6].id)

        @invoice_item_1 = create(:invoice_item, unit_price: 9000, quantity: 5, invoice_id: @invoice_1.id, item_id: @items[0].id)
        @invoice_item_2 = create(:invoice_item, unit_price: 2000, quantity: 3, invoice_id: @invoice_1.id, item_id: @items[2].id)
        @invoice_item_3 = create(:invoice_item, unit_price: 1200, quantity: 12, invoice_id: @invoice_2.id, item_id: @items[3].id)
        @invoice_item_4 = create(:invoice_item, unit_price: 4600, quantity: 10, invoice_id: @invoice_3.id, item_id: @items[6].id)
        @invoice_item_5 = create(:invoice_item, unit_price: 5500, quantity: 5, invoice_id: @invoice_4.id, item_id: @items[7].id)
        @invoice_item_6 = create(:invoice_item, unit_price: 1350, quantity: 4, invoice_id: @invoice_4.id, item_id: @items[4].id)
        @invoice_item_7 = create(:invoice_item, unit_price: 850, quantity: 10, invoice_id: @invoice_5.id, item_id: @items[2].id)
        @invoice_item_8 = create(:invoice_item, unit_price: 1440, quantity: 15, invoice_id: @invoice_6.id, item_id: @items[7].id)
        @invoice_item_9 = create(:invoice_item, unit_price: 54000, quantity: 11, invoice_id: @invoice_7.id, item_id: @items[1].id)
        @invoice_item_10 = create(:invoice_item, unit_price: 14400, quantity: 6, invoice_id: @invoice_7.id, item_id: @items[5].id)
        @invoice_item_11 = create(:invoice_item, unit_price: 77500, quantity: 1, invoice_id: @invoice_8.id, item_id: @items[4].id)
        @invoice_item_12 = create(:invoice_item, unit_price: 69500, quantity: 10, invoice_id: @invoice_9.id, item_id: @items[1].id)
        @invoice_item_13 = create(:invoice_item, unit_price: 99500, quantity: 5, invoice_id: @invoice_9.id, item_id: @items[3].id)
        @invoice_item_14 = create(:invoice_item, unit_price: 82000, quantity: 8, invoice_id: @invoice_10.id, item_id: @items[1].id)
        @invoice_item_15 = create(:invoice_item, unit_price: 26000, quantity: 12, invoice_id: @invoice_11.id, item_id: @items[5].id)
        @invoice_item_16 = create(:invoice_item, unit_price: 43000, quantity: 25, invoice_id: @invoice_12.id, item_id: @items[0].id)
        @invoice_item_17 = create(:invoice_item, unit_price: 99999, quantity: 15, invoice_id: @invoice_12.id, item_id: @items[3].id)
        @invoice_item_18 = create(:invoice_item, unit_price: 100000, quantity: 20, invoice_id: @invoice_12.id, item_id: @items[4].id)
        @invoice_item_18 = create(:invoice_item, unit_price: 50000, quantity: 8, invoice_id: @invoice_13.id, item_id: @items[4].id)

        @transaction_1 = create(:transaction, result: "failed", invoice_id: @invoice_1.id)
        @transaction_2 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
        @transaction_3 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
        @transaction_4 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_5 = create(:transaction, result: "failed", invoice_id: @invoice_2.id)
        @transaction_6 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_7 = create(:transaction, result: "success", invoice_id: @invoice_3.id)
        @transaction_8 = create(:transaction, result: "success", invoice_id: @invoice_4.id)
        @transaction_9 = create(:transaction, result: "failed", invoice_id: @invoice_5.id)
        @transaction_10 = create(:transaction, result: "success", invoice_id: @invoice_5.id)
        @transaction_11 = create(:transaction, result: "success", invoice_id: @invoice_6.id)
        @transaction_11 = create(:transaction, result: "success", invoice_id: @invoice_4.id)
        @transaction_12 = create(:transaction, result: "success", invoice_id: @invoice_7.id)
        @transaction_12 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_13= create(:transaction, result: "success", invoice_id: @invoice_5.id)
        @transaction_14 = create(:transaction, result: "success", invoice_id: @invoice_8.id)
        @transaction_15 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_16 = create(:transaction, result: "failed", invoice_id: @invoice_9.id)
        @transaction_17 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_18 = create(:transaction, result: "success", invoice_id: @invoice_10.id)
        @transaction_19 = create(:transaction, result: "failed", invoice_id: @invoice_11.id)
        @transaction_19 = create(:transaction, result: "success", invoice_id: @invoice_11.id)
        @transaction_20 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_21 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_22 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_23 = create(:transaction, result: "success", invoice_id: @invoice_11.id)
        @transaction_24 = create(:transaction, result: "failed", invoice_id: @invoice_13.id)
        @transaction_25 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_26 = create(:transaction, result: "success", invoice_id: @invoice_13.id)
        
        expect(@merchant.items.top_5_by_revenue).to match_array([@items[4], @items[3], @items[0], @items[1], @items[5]])
      end
    end

    describe "#top-selling-date" do 
      it "returns the specific day that a top-selling item generated the most revenue" do 
        @merchant = create(:merchant)
        @items = create_list(:item, 8, merchant_id: @merchant.id)
        @customers = create_list(:customer, 8)

        @invoice_1 = create(:invoice, status: rand(1..2), customer_id: @customers[5].id, created_at: Timecop.freeze(DateTime.new(2023, 8, 24)))
        @invoice_2 = create(:invoice, status: rand(1..2), customer_id: @customers[1].id, created_at: Timecop.freeze(DateTime.new(2023, 8, 24)))
        @invoice_3 = create(:invoice, status: rand(1..2), customer_id: @customers[2].id, created_at: Timecop.freeze(DateTime.new(2023, 8, 24)))
        @invoice_4 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id, created_at: Timecop.freeze(DateTime.new(2024, 1, 3)))
        @invoice_5 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id, created_at: Timecop.freeze(DateTime.new(2024, 1, 3)))
        @invoice_6 = create(:invoice, status: rand(1..2), customer_id: @customers[7].id, created_at: Timecop.freeze(DateTime.new(2024, 1, 3)))
        @invoice_7 = create(:invoice, status: rand(1..2), customer_id: @customers[1].id, created_at: Timecop.freeze(DateTime.new(2023, 6, 4)))
        @invoice_8 = create(:invoice, status: rand(1..2), customer_id: @customers[0].id, created_at: Timecop.freeze(DateTime.new(2023, 6, 4)))
        @invoice_9 = create(:invoice, status: rand(1..2), customer_id: @customers[3].id, created_at: Timecop.freeze(DateTime.new(2023, 6, 4)))
        @invoice_10 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id, created_at: Timecop.freeze(DateTime.new(2023, 3, 26)))
        @invoice_11 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id, created_at: Timecop.freeze(DateTime.new(2023, 3, 26)))
        @invoice_12 = create(:invoice, status: rand(1..2), customer_id: @customers[4].id, created_at: Timecop.freeze(DateTime.new(2023, 10, 23)))
        @invoice_13 = create(:invoice, status: rand(1..2), customer_id: @customers[6].id, created_at: Timecop.freeze(DateTime.new(2023, 10, 23)))

        @invoice_item_1 = create(:invoice_item, unit_price: 9000, quantity: 5, invoice_id: @invoice_1.id, item_id: @items[0].id)
        @invoice_item_2 = create(:invoice_item, unit_price: 2000, quantity: 3, invoice_id: @invoice_1.id, item_id: @items[2].id)
        @invoice_item_3 = create(:invoice_item, unit_price: 1200, quantity: 12, invoice_id: @invoice_2.id, item_id: @items[3].id)
        @invoice_item_4 = create(:invoice_item, unit_price: 4600, quantity: 10, invoice_id: @invoice_3.id, item_id: @items[6].id)
        @invoice_item_5 = create(:invoice_item, unit_price: 5500, quantity: 5, invoice_id: @invoice_4.id, item_id: @items[7].id)
        @invoice_item_6 = create(:invoice_item, unit_price: 1350, quantity: 4, invoice_id: @invoice_4.id, item_id: @items[4].id)
        @invoice_item_7 = create(:invoice_item, unit_price: 850, quantity: 10, invoice_id: @invoice_5.id, item_id: @items[2].id)
        @invoice_item_8 = create(:invoice_item, unit_price: 1440, quantity: 15, invoice_id: @invoice_6.id, item_id: @items[7].id)
        @invoice_item_9 = create(:invoice_item, unit_price: 54000, quantity: 11, invoice_id: @invoice_7.id, item_id: @items[1].id)
        @invoice_item_10 = create(:invoice_item, unit_price: 14400, quantity: 6, invoice_id: @invoice_7.id, item_id: @items[5].id)
        @invoice_item_11 = create(:invoice_item, unit_price: 77500, quantity: 1, invoice_id: @invoice_8.id, item_id: @items[4].id)
        @invoice_item_12 = create(:invoice_item, unit_price: 69500, quantity: 10, invoice_id: @invoice_9.id, item_id: @items[1].id)
        @invoice_item_13 = create(:invoice_item, unit_price: 99500, quantity: 5, invoice_id: @invoice_9.id, item_id: @items[3].id)
        @invoice_item_14 = create(:invoice_item, unit_price: 82000, quantity: 8, invoice_id: @invoice_10.id, item_id: @items[1].id)
        @invoice_item_15 = create(:invoice_item, unit_price: 26000, quantity: 12, invoice_id: @invoice_11.id, item_id: @items[5].id)
        @invoice_item_16 = create(:invoice_item, unit_price: 43000, quantity: 25, invoice_id: @invoice_12.id, item_id: @items[0].id)
        @invoice_item_17 = create(:invoice_item, unit_price: 99999, quantity: 15, invoice_id: @invoice_12.id, item_id: @items[3].id)
        @invoice_item_18 = create(:invoice_item, unit_price: 100000, quantity: 20, invoice_id: @invoice_12.id, item_id: @items[4].id)
        @invoice_item_18 = create(:invoice_item, unit_price: 50000, quantity: 8, invoice_id: @invoice_13.id, item_id: @items[4].id)

        @transaction_1 = create(:transaction, result: "failed", invoice_id: @invoice_1.id)
        @transaction_2 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
        @transaction_3 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
        @transaction_4 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_5 = create(:transaction, result: "failed", invoice_id: @invoice_2.id)
        @transaction_6 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_7 = create(:transaction, result: "success", invoice_id: @invoice_3.id)
        @transaction_8 = create(:transaction, result: "success", invoice_id: @invoice_4.id)
        @transaction_9 = create(:transaction, result: "failed", invoice_id: @invoice_5.id)
        @transaction_10 = create(:transaction, result: "success", invoice_id: @invoice_5.id)
        @transaction_11 = create(:transaction, result: "success", invoice_id: @invoice_6.id)
        @transaction_11 = create(:transaction, result: "success", invoice_id: @invoice_4.id)
        @transaction_12 = create(:transaction, result: "success", invoice_id: @invoice_7.id)
        @transaction_12 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
        @transaction_13= create(:transaction, result: "success", invoice_id: @invoice_5.id)
        @transaction_14 = create(:transaction, result: "success", invoice_id: @invoice_8.id)
        @transaction_15 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_16 = create(:transaction, result: "failed", invoice_id: @invoice_9.id)
        @transaction_17 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_18 = create(:transaction, result: "success", invoice_id: @invoice_10.id)
        @transaction_19 = create(:transaction, result: "failed", invoice_id: @invoice_11.id)
        @transaction_19 = create(:transaction, result: "success", invoice_id: @invoice_11.id)
        @transaction_20 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_21 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_22 = create(:transaction, result: "success", invoice_id: @invoice_12.id)
        @transaction_23 = create(:transaction, result: "success", invoice_id: @invoice_11.id)
        @transaction_24 = create(:transaction, result: "failed", invoice_id: @invoice_13.id)
        @transaction_25 = create(:transaction, result: "success", invoice_id: @invoice_9.id)
        @transaction_26 = create(:transaction, result: "success", invoice_id: @invoice_13.id)

        top_5 = @merchant.items.top_5_by_revenue

        expect(top_5[0].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[1].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[2].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[3].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Sunday, June 04, 2023")
        expect(top_5[4].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Sunday, March 26, 2023")
      end
    end
  end

end