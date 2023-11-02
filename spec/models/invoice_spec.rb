require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it {should belong_to(:customer) }
  end

  describe "methods" do
    before :each do
      @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
      @customer2 = Customer.create!(first_name: "Cecelia", last_name: "Osinski")
      @customer3 = Customer.create!(first_name: "Mariah", last_name: "Toy")
      @customer4 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      @customer5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      @customer6 = Customer.create!(first_name: "Heber", last_name: "Kuhn")
      @customer7 = Customer.create!(first_name: "Parker", last_name: "Daugherty")

      @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id)
      @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id)
      @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id)
      @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id)
      @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id)
      @invoice7 = Invoice.create!(status: "completed", customer_id: @customer7.id)
      @invoice8 = Invoice.create!(status: "in progress", customer_id: @customer7.id)
      @invoice9 = Invoice.create!(status: "in progress", customer_id: @customer7.id)
      @invoice10 = Invoice.create!(status: "cancelled", customer_id: @customer7.id)
    end

    describe "#self.incomplete" do
      it "gives all invoices with a status of in progress" do
        expect(Invoice.incomplete).to eq([@invoice8, @invoice9])
      end
    end
  end
end