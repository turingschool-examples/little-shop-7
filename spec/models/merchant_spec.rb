require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  describe "relationships" do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe "instance methods" do 
    before(:each) do
      @merchant1 = Merchant.create!(name:"Merchy McMerchface")
  
      @customer1 = Customer.create!(first_name:"Paul", last_name: "McCartney")
      @customer2 = Customer.create!(first_name:"John", last_name: "Lennon")
      @customer3 = Customer.create!(first_name:"George", last_name: "Harrison")
      @customer4 = Customer.create!(first_name:"Ringo", last_name: "Starr")
      @customer5 = Customer.create!(first_name:"Penny", last_name: "Lane")
      @customer8 = Customer.create!(first_name:"Leo", last_name: "Wyatt")
  
      @invoice1 = @customer1.invoices.create!(status: 0)
      @invoice2 = @customer1.invoices.create!(status: 0)
      @invoice3 = @customer2.invoices.create!(status: 0)
      @invoice4 = @customer3.invoices.create!(status: 0)
      @invoice5 = @customer4.invoices.create!(status: 0)
      @invoice6 = @customer5.invoices.create!(status: 0)
  
      @item1 = @merchant1.items.create!(name: "Thing", description: "V cool", unit_price: 10000)
      @invoice1.items << @item1
      @invoice2.items << @item1
      @invoice3.items << @item1
      @invoice4.items << @item1
      @invoice5.items << @item1
      @invoice6.items << @item1
      
      @transaction0 = @invoice1.transactions.create!(credit_card_number: "123345456567", credit_card_expiration_date: "04/27", result: "failed")
      @transaction1 = @invoice1.transactions.create!(credit_card_number: "435345456567", credit_card_expiration_date: "04/27", result: "success")
      @transaction2 = @invoice2.transactions.create!(credit_card_number: "567567456567", credit_card_expiration_date: "04/27", result: "success")
      @transaction3 = @invoice3.transactions.create!(credit_card_number: "789785456567", credit_card_expiration_date: "04/27", result: "success")
      @transaction4 = @invoice4.transactions.create!(credit_card_number: "789785456567", credit_card_expiration_date: "04/27", result: "success")
      @transaction5 = @invoice5.transactions.create!(credit_card_number: "097867456567", credit_card_expiration_date: "04/27", result: "success")
      @transaction6 = @invoice6.transactions.create!(credit_card_number: "123453453467", credit_card_expiration_date: "04/27", result: "success")
    end

    describe "#favorite_customers" do
      it "returns the top 5 customers with the most successful transactions for a merchant " do
        expect(@merchant1.favorite_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
        expect(@merchant1.favorite_customers).to_not eq(@customer8)
      end
    end
  end
end