require "rails_helper"

RSpec.describe Merchant, type: :model do 
  describe "relationships" do 
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "instance methods" do 
    let!(:merchant) { create(:merchant, name:"Dealer of Death", status: 1 )}
    let!(:merchant2) { create(:merchant, name:"Dealer of Life", status: 1 )}

    let!(:items_m1) { create_list(:item, 5, merchant_id: merchant.id)}
    let!(:items_m2) { create_list(:item, 5, merchant_id: merchant2.id)}

    let!(:customer1) { create(:customer, first_name: "Austin" )}
    let!(:customer2) { create(:customer, first_name: "Jimmy" )}

    let!(:invoice1) { create(:invoice, id: 1, created_at: "2012-03-25 09:54:09 UTC", customer_id: customer1.id )}
    let!(:invoice2) { create(:invoice, id: 2, created_at: "2012-05-25 09:54:09 UTC", customer_id: customer1.id )}
    let!(:invoice3) { create(:invoice, id: 3, created_at: "2012-07-25 09:54:09 UTC", customer_id: customer1.id )}
    let!(:invoice4) { create(:invoice, id: 4, created_at: "2012-09-25 09:54:09 UTC", customer_id: customer1.id )}
    
    let!(:invoice5) { create(:invoice, id: 5, created_at: "2013-03-25 09:54:09 UTC", customer_id: customer2.id )}
    let!(:invoice6) { create(:invoice, id: 6, created_at: "2013-05-25 09:54:09 UTC", customer_id: customer2.id )}
    let!(:invoice7) { create(:invoice, id: 7, created_at: "2013-06-25 09:54:09 UTC", customer_id: customer2.id )}
    let!(:invoice8) { create(:invoice, id: 8, created_at: "2013-12-25 09:54:09 UTC", customer_id: customer2.id )}

    let!(:invoice_item1) { create(:invoice_item, id: 1, status: 0, item_id: items_m1[1].id, invoice_id: invoice1.id )}
    let!(:invoice_item2) { create(:invoice_item, id: 2, status: 1, item_id: items_m1[4].id, invoice_id: invoice2.id )}
    let!(:invoice_item3) { create(:invoice_item, id: 3, status: 1, item_id: items_m1[3].id, invoice_id: invoice3.id )}
    let!(:invoice_item4) { create(:invoice_item, id: 4, status: 2, item_id: items_m1[2].id, invoice_id: invoice4.id )}

    let!(:invoice_item5) { create(:invoice_item, id: 5, status: 0, item_id: items_m2[0].id, invoice_id: invoice5.id )}
    let!(:invoice_item6) { create(:invoice_item, id: 6, status: 2, item_id: items_m2[2].id, invoice_id: invoice6.id )}
    let!(:invoice_item7) { create(:invoice_item, id: 7, status: 2, item_id: items_m2[4].id, invoice_id: invoice7.id )}
    let!(:invoice_item8) { create(:invoice_item, id: 8, status: 1, item_id: items_m2[3].id, invoice_id: invoice8.id )}

    describe "#not_shipped_items" do 
      it "displays the not yet shipped items ordered by least recent invoice creation date" do
        expect(merchant.not_shipped_items).to eq([invoice1, invoice2, invoice3])
        expect(merchant2.not_shipped_items).to eq([invoice5, invoice8])
      end
    end
  end
end