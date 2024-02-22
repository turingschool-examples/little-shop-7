require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'Enums' do
    xit 'enums tests' do
    end
  end

  before(:each) do
    @customers = create_list(:customer, 10)
    @customer_1 = @customers[0]
    @customer_2 = @customers[1]
    @customer_3 = @customers[2]
    @customer_4 = @customers[3]
    @customer_5 = @customers[4]
    @customer_6 = @customers[5]
    @customer_7 = @customers[6]
    @customer_8 = @customers[7]
    @customer_9 = @customers[8]
    @customer_10 = @customers[9]
    @invoice_1 = @customer_1.invoices[0]
    @invoice_2 = @customer_1.invoices[1]
    @invoice_3 = @customer_1.invoices[2]
    @invoice_4 = @customer_1.invoices[3]
    @invoice_5 = @customer_1.invoices[4]
    @invoice_6 = @customer_2.invoices[0]
    @invoice_7 = @customer_2.invoices[1]
    @invoice_8 = @customer_2.invoices[2]
    @invoice_9 = @customer_2.invoices[3]
    @invoice_10 = @customer_2.invoices[4]
    @invoice_11 = @customer_3.invoices[0]
    @invoice_12 = @customer_3.invoices[1]
    @invoice_13 = @customer_3.invoices[2]
    @invoice_14 = @customer_3.invoices[3]
    @invoice_15 = @customer_3.invoices[4]
    @invoice_16 = @customer_4.invoices[0]
    @invoice_17 = @customer_4.invoices[1]
    @invoice_18 = @customer_4.invoices[2]
    @invoice_19 = @customer_4.invoices[3]
    @invoice_20 = @customer_4.invoices[4]
    @invoice_21 = @customer_5.invoices[0]
    @invoice_22 = @customer_5.invoices[1]
    @invoice_23 = @customer_5.invoices[2]
    @invoice_24 = @customer_5.invoices[3]
    @invoice_25 = @customer_5.invoices[4]

    @merchants = create_list(:merchant, 10)
    @merchant_1 = @merchants[0]
    @merchant_2 = @merchants[1]
    @merchant_3 = @merchants[2]
    @merchant_4 = @merchants[3]
    @merchant_5 = @merchants[4]
    @merchant_6 = @merchants[5]
    @merchant_7 = @merchants[6]
    @merchant_8 = @merchants[7]
    @merchant_9 = @merchants[8]
    @merchant_10 = @merchants[9]
    @item_1 = @merchant_1.items[0]
    @item_2 = @merchant_1.items[1]
    @item_3 = @merchant_1.items[2]
    @item_4 = @merchant_1.items[3]
    @item_5 = @merchant_1.items[4]

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 1300, status: 1)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: 1300, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1300, status: 2)
  end

  describe 'Class Methods' do
    describe '#invoices_with_unshipped_items' do
      it 'will return all invoices that do not have a status of completed' do

        expect(Invoice.invoices_with_unshipped_items).to eq([@invoice_1, @invoice_2, @invoice_3])

      end
    end
  end
end
