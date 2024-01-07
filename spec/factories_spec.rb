# We should move our old factory bot testing here too

require 'rails_helper'

RSpec.describe "Factory::Faker Bot", type: :model do
    
  it 'creates an invoice_item' do
    invoice_item = create(:invoice_item)

    expect(invoice_item).to be_valid
    expect(invoice_item.invoice).to be_present
    expect(invoice_item.item).to be_present
    expect(invoice_item.quantity).to be_between(1, 5).inclusive
    expect(invoice_item.unit_price).to be > 0
    # I don't know how to test for enums...
    # expect(invoice_item.status).to eq("pending" | "packaged" | "shipped")
  end
end