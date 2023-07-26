require "rails_helper"

RSpec.describe Item, type: :model do
  before(:each) do
    test_data
  end
  describe "validations" do
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant}
  end
end