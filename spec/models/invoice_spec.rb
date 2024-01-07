require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "assocations" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many :items }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values([:"in progress", :completed, :cancelled]) }
  end

  describe "methods" do
    it "formats created_at date" do
      @customer = create(:customer)
      @invoice = create(:invoice, created_at: "2019-07-18 00:00:00")
    
      expect(@invoice.format_created_date).to eq("Thursday, July 18, 2019")
    end
  end
end
