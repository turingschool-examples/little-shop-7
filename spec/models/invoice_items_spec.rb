require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
   describe 'relationships' do
      it { should belong_to :invoice }
      it { should belong_to :item }
   end

   describe '#converted_unit_price' do
      it 'converts the unit price from cents to dollars' do
         invoice_item = create(:invoice_item, unit_price: 40000)

         expect(invoice_item.converted_unit_price).to eq(400.00)
      end
   end
end