require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
  end

  describe "#top_5_customers" do
    it "displays the top 5 customers" do
      @merchant1 = Merchant.create!(name: "Hannah's Handbags")
      @merchant2 = Merchant.create!(name: "Jason's Furniture")

      @customer1 = Customer.create!(first_name: "John", last_name: "Jacobs")
      @customer2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
      @customer3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
      @customer4 = Customer.create!(first_name: "Harry", last_name: "Potter")
      @customer5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
      @customer6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")
      @customer7 = Customer.create!(first_name: "Jackie", last_name: "Chan")
      
      @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
      @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
      @invoice4 = Invoice.create!(status: 2, customer_id: @customer4.id)
      @invoice5 = Invoice.create!(status: 2, customer_id: @customer5.id)
      @invoice6 = Invoice.create!(status: 2, customer_id: @customer6.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @customer7.id)
      @invoice8 = Invoice.create!(status: 0, customer_id: @customer7.id)

      @transaction1 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice2.id)
      @transaction3 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice3.id)
      @transaction4 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice4.id)
      @transaction5 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice5.id)
      @transaction6 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice6.id)
      @transaction7 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice7.id)

      top_5 = @merchant1.top_5_customers

      expect(top_5).to eq([@customer2, @customer3, @customer4, @customer5, @customer6])
      expect(top_5).to_not include(@customer1)
      expect(top_5).to_not include(@customer7)
    end
  end

  describe "#button_text" do 
    it "if merchant status is 'enabled' it returns 'Disable,' otherwise it returns 'enable'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.button_text).to eq("Disable")
      expect(merchant_2.button_text).to eq("Enable")
    end
  end

  describe "#enabled?" do
    before(:each) do 
     end
    it "returns true if the merchan's status is 'enabled' and false if merchant status is 'disabled'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.enabled?).to eq(true)
      expect(merchant_2.enabled?).to eq(false)
    end
  end

  describe "#toggle_status" do 
    it "returns the integer 0 if merchant status is 'enabled' and integer value 1 if merchant status is 'disabled'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.toggle_status).to eq(0)
      expect(merchant_2.toggle_status).to eq(1)
    end
  end

  describe "@sort_by_name" do 
    it "sorts the merchants alphabetically ascending by name" do
      merchant_1 = Merchant.create!({name: "Wilson & Co."})
      merchant_2 = Merchant.create!({name: "Andersen, Anderson, & Anderssen"})
      merchant_3 = Merchant.create!({name: "Rumpke & Assoc., LLC"})
      merchant_4 = Merchant.create!({name: "Liebowitz & Sons, Inc."})
      merchant_5 = Merchant.create!({name: "McClaren Group"})

      expect(Merchant.sort_by_name).to eq([merchant_2, merchant_4, merchant_5, merchant_3, merchant_1])
    end
  end

end