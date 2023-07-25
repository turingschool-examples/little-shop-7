require 'rails_helper'

describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_numericality_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_numericality_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
    it { should validate_presence_of :status }
  end
end