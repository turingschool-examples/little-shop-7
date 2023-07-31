require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
  end

  describe "class methods" do
    describe ".incomplete_invoices" do
      before :each do
        invoice_spec_test_data
      end

      it "Can return all invoices with unshipped items ordered by oldest to newest" do
        incomplete_invoices = Invoice.incomplete_invoices
    
        expect(incomplete_invoices.count).to eq(6)
        expect(incomplete_invoices.sample).to be_a(Invoice)
        expect(incomplete_invoices).to eq([@invoice_8, @invoice_5, @invoice_3, @invoice_1, @invoice_2, @invoice_4])
      end
    end
  end

  describe 'instance methods' do 
    describe '#total_revenue' do
      before :each do
        invoice_spec_test_data
      end

      it 'returns the total revenue for an invoice in cents' do
        expect(@invoice_1.total_revenue).to eq(68175)
        expect(@invoice_2.total_revenue).to eq(209916)
      end
      
      it "returns an integer for total revenue" do
        invoice_spec_test_data

        expect(@invoice_1.total_revenue).to be_a(Integer)
      end
    end

    describe "#total_revenue_to_currency" do
      before :each do
        invoice_spec_test_data
      end

      it 'returns the total revenue for an invoice in dollars' do
        expect(@invoice_1.total_revenue_to_currency).to eq("$681.75")
        expect(@invoice_2.total_revenue_to_currency).to eq("$2,099.16")
      end

      it "returns a string for total revenue to currency" do
        expect(@invoice_1.total_revenue_to_currency).to be_a(String)
      end
    end

    describe "#merchant_invoice_items(merchant_id)" do
      before :each do
        merchant_invoice_test_data
      end

      it "returns the invoice_items for a specific a merchant" do
        # invoice_1 has two invoice_items from merchant_1
        merch1_inv1_expected = [@invoice1_item_1, @invoice1_item_2]
        merch1_inv1_result = @invoice_1.merchant_invoice_items(@merchant_1.id)
        expect(merch1_inv1_result).to eq(merch1_inv1_expected)

        # invoice_2 has one invoice_item from merchant_1 and one invoice_item from merchant_2
        # invoice_2 for merchant_1
        merch1_inv2_expected = [@invoice2_item_3]
        merch1_inv2_result = @invoice_2.merchant_invoice_items(@merchant_1.id)
        expect(merch1_inv2_result).to eq(merch1_inv2_expected)
        
        # invoice_2 for merchant_2
        merch2_inv2_expected = [@invoice2_item_4]
        merch2_inv2_result = @invoice_2.merchant_invoice_items(@merchant_2.id)
        expect(merch2_inv2_result).to eq(merch2_inv2_expected)
      end
    end

    describe "#merchant_revenue(merchant_id)" do
      before :each do
        merchant_invoice_test_data
      end

      it "returns the total revenue from a specific merchant's items" do
        # invoice_1 has two invoice_items from merchant_1
        merch1_inv1_item_1_rev = @invoice1_item_1.unit_price * @invoice1_item_1.quantity  # =>  68175
        merch1_inv1_item_2_rev = @invoice1_item_2.unit_price * @invoice1_item_2.quantity  # => 667470
        merch1_inv1_total_rev = merch1_inv1_item_2_rev + merch1_inv1_item_1_rev           # => 735645

        expect(@invoice_1.merchant_revenue(@merchant_1.id)).to eq(merch1_inv1_total_rev)

        # invoice_2 has one invoice_item from merchant_1 and one invoice_item from merchant_2
        # invoice_2 for merchant_1
        merch1_inv2_item_3_rev = @invoice2_item_3.unit_price * @invoice2_item_3.quantity
        
        expect(@invoice_2.merchant_revenue(@merchant_1.id)).to eq(merch1_inv2_item_3_rev) # => 209916
        
        # invoice_2 for merchant_2
        merch2_inv2_item_4_rev = @invoice2_item_4.unit_price * @invoice2_item_4.quantity
        
        expect(@invoice_2.merchant_revenue(@merchant_2.id)).to eq(merch2_inv2_item_4_rev) # => 692469
      end
    end
    
    describe "#merchant_revenue_to_currency(merchant_id)" do
      before :each do
        merchant_invoice_test_data
      end

      it "returns the total revenue from a specific merchant's items as a formatted string" do
        expect(@invoice_1.merchant_revenue_to_currency(@merchant_1.id)).to eq("$7,356.45")
        
        expect(@invoice_2.merchant_revenue_to_currency(@merchant_1.id)).to eq("$2,099.16")
        
        expect(@invoice_2.merchant_revenue_to_currency(@merchant_2.id)).to eq("$6,924.69")
      end
    end
  end
end
