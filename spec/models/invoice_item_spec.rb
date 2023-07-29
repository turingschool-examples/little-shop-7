require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do 
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  before :each do
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item = @merchant.items.create!(name: 'Qui Esse', description: 'Nihil autem sit odio inventore deleniti', unit_price: 75107)
    @invoice = @customer.invoices.create!(status: 'in progress', created_at: Time.new(2000))
    @invoice_item = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item.id, quantity: 5, unit_price: 13635, status: 'packaged')

  end

  describe "instance methods" do
    describe "#dollar_price" do
      it "converts the unit price (cents) into dollars" do
        expect(@invoice_item.dollar_price).to eq(136.35)
      end
    end
  end
end
