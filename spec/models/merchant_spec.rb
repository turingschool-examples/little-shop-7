require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
  end

  describe "#revenue" do
    it "can calculate the total amount of sales for a merchant" do
      # Notes on Revenue Calculation:
      #   - Only invoices with at least one successful transaction should count towards revenue
      #   - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      #   - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)


    end
  end

  describe "#top_5_merchants" do
    it "returns the top merchants with the highest revenue generated" do

    end
  end
end
