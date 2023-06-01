require "rails_helper"

RSpec.describe "Index" do
  it "displays invoice items Index" do
    # merchant = create(:merchant)
    invoice_item = create(:invoice_item)
    # require 'pry'; binding.pry
    puts invoice_item.item_id
    puts invoice_item.invoice_id
    puts invoice_item.quantity
    puts invoice_item.unit_price
    puts invoice_item.status
  end
end

# create_list(:customer, 3)