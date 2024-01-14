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
        merchant = create(:merchant)
        create_list(:item, 10, merchant_id: merchant.id)
        
        (0..4).each do |n|
          create(:invoice_item, status: rand(0..1), item_id: merchant.items[n].id)
        end
  
        (5..9).each do |n|
          create(:invoice_item, status: 2, item_id: merchant.items[n].id)
        end

        Item.ready_to_ship.each do |item|
          expect(item.status != "shipped")
        end
      end
    end
    
    describe "::top_5_by_revenue" do 
      it "returns a merchant's top 5 items based on total revenue" do
        load_data

        expect(@merchant.items.top_5_by_revenue).to match_array([@items[4], @items[2], @items[0], @items[1], @items[3]])
      end
    end

    describe "#top-selling-date" do 
      it "returns the specific day that a top-selling item generated the most revenue" do 
        load_data

        top_5 = @merchant.items.top_5_by_revenue

        expect(top_5[0].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[1].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[2].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Monday, October 23, 2023")
        expect(top_5[3].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Sunday, June 04, 2023")
        expect(top_5[4].top_selling_date.sale_date.strftime('%A, %B %d, %Y')).to eq("Sunday, June 04, 2023")
      end
    end
  end

end