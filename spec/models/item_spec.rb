require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "class methods" do 
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
  end

end