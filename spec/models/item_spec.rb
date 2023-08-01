require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it { should belong_to :merchant}
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods" do
    it "can update status" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: true)

      item.update_status

      expect(item.status).to eq(false)

      item.update_status

      expect(item.status).to eq(true)
    end
  end
end