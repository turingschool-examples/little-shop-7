require 'rails_helper'

RSpec.describe Item, type: :model do
   describe 'relationships' do
      it { should belong_to :merchant }
      it { should have_many :invoice_items }
      it { should have_many(:invoices).through(:invoice_items) }
   end

   describe 'enabled_item' do
     it 'returns only enabled items' do
         @merchant1 = Merchant.create!(name: "Merchant A")
         @merchant2 = Merchant.create!(name: "Merchant B")
   
         @item1 = Item.create!(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
         @item2 = Item.create!(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
         @item3 = Item.create!(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2, status: 1)
         @item4 = Item.create!(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2, status: 1)
         
  
       expect(Item.enabled_items).to eq([@item1,@item2])
       expect(Item.enabled_items).to_not eq([@item3,@item4])
     end
   end

   describe 'disabled_items' do
     it 'returns only enabled items' do
         @merchant1 = Merchant.create!(name: "Merchant A")
         @merchant2 = Merchant.create!(name: "Merchant B")
   
         @item1 = Item.create!(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
         @item2 = Item.create!(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
         @item3 = Item.create!(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2, status: 1)
         @item4 = Item.create!(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2, status: 1)
         
  
         expect(Item.disabled_items).to eq([@item3,@item4])
         expect(Item.disabled_items).to_not eq([@item1,@item2])
     end
   end
end