require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:customers) }
    it { should have_many(:invoice_items).through(:items) }
  end

#   describe "validations" do
#     it { should validate_presence_of(:name) }
#   end

  describe "#top_customers" do
    let(:merchant) { FactoryBot.create(:merchant) }
    let(:item) { FactoryBot.create(:item, merchant: merchant) }
    let(:top_customers) { FactoryBot.create_list(:customer, 5) }
    let(:customers) { FactoryBot.create_list(:customer, 5) }

    before do
      top_customers.each do |customer|
        invoice = FactoryBot.create(:invoice, customer: customer)
        invoice.items = [item]
        FactoryBot.create_list(:transaction, Random.rand(2..5), invoice: invoice)
        invoice.save!
      end
      customers.each do |customer|
        invoice = FactoryBot.create(:invoice, customer: customer)
        invoice.items = [item]
        FactoryBot.create_list(:transaction, 1, invoice: invoice)
        invoice.save!
      end
    end
    it "returns the top 5 customers with their success transactions counts in descending order" do
      expect(merchant.top_customers).to match_array(top_customers)
    end
  end

  describe "#items_ready_to_ship" do
    let(:merchant) { FactoryBot.create(:merchant) }
    let(:item_1) { FactoryBot.create(:item, merchant: merchant) }
    let(:item_2) { FactoryBot.create(:item, merchant: merchant) }
    let(:item_3) { FactoryBot.create(:item, merchant: merchant) }
    let(:customer) { FactoryBot.create(:customer) }

    it "returns the array of invoice_items that do not have status 'shipped' and in ascending order of invoice created_at" do
      invoice_1 = FactoryBot.create(:invoice, customer: customer)
      invoice_2 = FactoryBot.create(:invoice, customer: customer)
      invoice_3 = FactoryBot.create(:invoice, customer: customer)

      invoice_item_1 = InvoiceItem.create!(invoice: invoice_1, item: item_1, status: "pending")
      invoice_item_2 = InvoiceItem.create!(invoice: invoice_2, item: item_2, status: "packaged")
      invoice_item_3 = InvoiceItem.create!(invoice: invoice_3, item: item_3, status: "shipped")

      expect(merchant.items_ready_to_ship).to eq([invoice_item_2])
    end
  end

  describe '#calculate_top_items' do
    it 'returns the top 5 items by revenue' do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant: merchant)

      items.each do |item|
        invoice = create(:invoice)
        transaction = create(:transaction, invoice: invoice, result: 'success')
        create(:invoice_item, item: item, invoice: invoice, quantity: Random.rand(1..2), unit_price: 10)
      end

      top_items = create_list(:item, 5, merchant: merchant)

      top_items.each do |top_item|
        invoice = create(:invoice)
        transaction = create(:transaction, invoice: invoice, result: 'success')
        create(:invoice_item, item: top_item, invoice: invoice, quantity: Random.rand(3..9), unit_price: 10)
      end

      expect(merchant.calculate_top_items).to match_array(top_items)
    end
  end

  describe '#calculate_top_items_with_dates' do
  let(:merchant) { create(:merchant) }
  let!(:items) { create_list(:item, 5, merchant: merchant) }
  let(:dates) { [Date.new(2023, 1, 5), Date.new(2023, 1, 4), Date.new(2023, 1, 3), Date.new(2023, 1, 2), Date.new(2023, 1, 1)] }

  before do
    items.each_with_index do |item, index|
      invoice = create(:invoice, created_at: dates[index])
      transaction = create(:transaction, invoice: invoice, result: 'success')
      create(:invoice_item, item: item, invoice: invoice, quantity: Random.rand(1..2), unit_price: 10)
    end
  end

  it 'returns the top dates for top items' do
    top_items = merchant.calculate_top_items
    top_items_with_dates = merchant.calculate_topitems_date(top_items)

    expected_dates = ['2023-01-05', '2023-01-04', '2023-01-03', '2023-01-02', '2023-01-01']

    top_items_with_dates.each do |(item, date)|
      expect(expected_dates).to include(date)
     
    end
  end
end

end
