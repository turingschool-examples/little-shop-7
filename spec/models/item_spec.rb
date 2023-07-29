require 'rails_helper'

RSpec.describe Item, type: :model do 
  describe "relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end


  describe "instance methods" do 
    describe "#currrent_price" do
      it "returns the unit price as $xx.xx " do
        merchant_3 = Merchant.create!(name: 'Willms and Sons')
        item_1 = merchant_3.items.create!(name: 'Gold Ring', description: 'A ring thats gold', unit_price: 75107)
        item_2 = merchant_3.items.create!(name: 'Silver ring', description: 'A ring thats silver', unit_price: 45107)
        expect(item_1.current_price).to eq("$75.11")
        expect(item_2.current_price).to eq("$45.11")
      end
    end
  end
end