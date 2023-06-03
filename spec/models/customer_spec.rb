require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }

    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id) }
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id) }
    let!(:invoice_3) { create(:invoice, customer_id: customer_3.id) }
    let!(:invoice_4) { create(:invoice, customer_id: customer_4.id) }
    let!(:invoice_5) { create(:invoice, customer_id: customer_5.id) }
    let!(:invoice_6) { create(:invoice, customer_id: customer_6.id) }

    let!(:trans_1_s) { create_list(:transaction, 1, result: 1, invoice_id: invoice_1.id) }
    let!(:trans_2_s) { create_list(:transaction, 2, result: 1, invoice_id: invoice_2.id) }
    let!(:trans_3_s) { create_list(:transaction, 3, result: 1, invoice_id: invoice_3.id) }
    let!(:trans_4_s) { create_list(:transaction, 4, result: 1, invoice_id: invoice_4.id) }
    let!(:trans_5_s) { create_list(:transaction, 5, result: 1, invoice_id: invoice_5.id) }
    let!(:trans_6_f) { create_list(:transaction, 6, result: 0, invoice_id: invoice_6.id) }

    context "#top_5_customers" do
      it "returns the top 5 customers by successful transactions" do
        expect(Customer.top_5_customers).to eq([customer_5, customer_4, customer_3, customer_2, customer_1])
      end
    end
  end

end