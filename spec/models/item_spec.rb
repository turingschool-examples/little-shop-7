require 'rails_helper'

RSpec.describe Item, type: :model do

  context "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  context "validations" do 
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  before(:each) do
    @merchant = create(:merchant)
    # require 'pry'; binding.pry
    # @item = @merchant.items.create()
    attributes = attributes_for(:item)
    # require 'pry'; binding.pry
    @item = @merchant.items.create(attributes)
  end

end
