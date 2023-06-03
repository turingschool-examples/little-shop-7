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

  describe "instance methods" do
    it "#formatted_time" do
      expect(@invoice.formatted_time).to eq(@invoice.created_at.to_datetime.strftime("%A, %B %d, %Y"))
    end
  end
end
