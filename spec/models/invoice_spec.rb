require 'rails_helper'

RSpec.describe Invoice, type: :model do

  context "relationship" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end

  context "validations" do
    it { should validate_presence_of :status}
  end

  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)
    @invoice = create(:invoice, customer_id: @customer.id)
  end

end
