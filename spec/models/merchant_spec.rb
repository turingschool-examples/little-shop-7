require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end



  describe "instance methods" do
    describe "Merchant Dashboard" do
      let!(:merchant) {create(:merchant)}
      let!(:item) {create(:item, merchant: merchant)}
      let!(:customer_1) {create(:customer)}
      let!(:customer_2) {create(:customer)}
      let!(:customer_3) {create(:customer)}
      let!(:customer_4) {create(:customer)}
      let!(:customer_5) {create(:customer)}
      let!(:customer_6) {create(:customer)}
      let!(:invoice_1) {create(:invoice, customer: customer_1)}
      let!(:invoice_2) {create(:invoice, customer: customer_2)}
      let!(:invoice_3) {create(:invoice, customer: customer_3)}
      let!(:invoice_4) {create(:invoice, customer: customer_4)}
      let!(:invoice_5) {create(:invoice, customer: customer_5)}
      let!(:invoice_6) {create(:invoice, customer: customer_6)}
      
      let!(:transaction_1) {create(:transaction, :success, invoice: invoice_1)}
      let!(:transaction_2) {create(:transaction, :success, invoice: invoice_2)}
      let!(:transaction_3) {create(:transaction, :success, invoice: invoice_3)}
      let!(:transaction_4) {create(:transaction, :success, invoice: invoice_4)}
      let!(:transaction_5) {create(:transaction, :success, invoice: invoice_5)}
      let!(:transaction_6) {create(:transaction, :success, invoice: invoice_6)}
      let!(:transaction_7) {create(:transaction, :success, invoice: invoice_1)}


      let!(:invoice_item_1) {create(:invoice_item, :shipped, item: item, invoice: invoice_1)}
      let!(:invoice_item_2) {create(:invoice_item, :shipped, item: item, invoice: invoice_2)}
      let!(:invoice_item_3) {create(:invoice_item, :shipped, item: item, invoice: invoice_3)}
      let!(:invoice_item_4) {create(:invoice_item, :shipped, item: item, invoice: invoice_4)}
      let!(:invoice_item_5) {create(:invoice_item, :shipped, item: item, invoice: invoice_5)}
      let!(:invoice_item_6) {create(:invoice_item, :shipped, item: item, invoice: invoice_6)}

      #User Story 3
      it "creates an array of 5 customers" do
        top_customers = merchant.top_five_customers

        #Method limits 5 customers
        expect(top_customers.length).to eq(5)
        #Only customer that has 2 transactions is the top customer
        expect(top_customers.first).to eq(customer_1)
        
      end

      #User Story 4
      describe "Items Ready to Ship" do
        let!(:item_2) {create(:item, merchant: merchant)}
        let!(:invoice_item_pending) {create(:invoice_item, :pending, item: item_2, invoice: invoice_1 )}
        let!(:invoice_item_pending_2) {create(:invoice_item, :pending, item: item_2, invoice: invoice_1 )}
        
        it "lists a name of all of all the merchants items that have status: packaged" do
          pending_packages = merchant.pending_items
          
          #An Array of packages that have the pending status only. 
          expect(pending_packages.length).to eq(2)
          expect(pending_packages.second.invoice_items.first.status).to eq("pending")   
        end

        #User Story 5
        describe "oldest_to_newest" do
          it "displays items ready to ship and their invoice is oldest to newest" do
            arranged_packages = merchant.incomplete_invoices
            #This will check that the invoice on :65 happens before the invoice on :66
            expect(arranged_packages.first).to eq(invoice_item_pending)
            
          end
        end
      end
    end
  end
end