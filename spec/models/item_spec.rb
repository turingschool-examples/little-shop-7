require "rails_helper"

RSpec.describe Item, type: :model do
  before (:each) do
    @merchant1 = Merchant.create!(name: "Hannah's Handbags")
      @item1 = Item.create!(
        name: "Item Qui Esse",
        description:
        "Nihil autem sit odio inventore deleniti.",
        unit_price: 75107,
        merchant_id: @merchant1.id,
        status: "enabled"
      )
      @item2 = Item.create!(
        name: "Item Qui Esse",
        description:
        "Nihil autem sit odio inventore deleniti.",
        unit_price: 75107,
        merchant_id: @merchant1.id,
        status: "disabled"
      )
      @customer1 = Customer.create!(first_name: "Alan", last_name: "Smith")
      @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
      @invoice_item = InvoiceItem.create!(quantity: 5, unit_price: 10, status: 1, item_id: @item1.id, invoice_id: @invoice1.id)
  end
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }

  end

  describe 'packaged' do
    it 'should return the invoice id' do
      

      expect(@item1.packaged).to eq(@item1)
    
    end
  end

  describe 'invoice_ids' do
    it 'plucks the invoice id' do
      
      
      expect(@item1.invoice_ids).to eq([@invoice1.id])
    end
  end
    describe 'invoice_date' do
      it 'plucks the invoice date' do
      
      
      expect(@item1.invoice_date).to eq(@invoice1.creation_date)
    end
  end

  describe 'button_text' do 
    it "provides the enable/disable button text" do
    


      expect(@item1.button_text).to eq("Disable")
      expect(@item2.button_text).to eq("Enable")
    end
  end
  describe "toggle_status" do
    it "flips the status" do 
      expect(@item1.status).to eq("enabled")
      @item1.toggle_status
      expect(@item1.status).to eq("disabled")
      @item1.toggle_status
      expect(@item1.status).to eq("enabled")
    end
  end
end
  