require "rails_helper"

RSpec.describe "Merchant Dashboard Page", type: :feature do
  
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

  # 1. Merchant Dashboard
  it "shows the merchant name" do
    visit merchant_dashboard_path(@merchant1)

    within("div#merchant-header") do
      expect(page).to have_content(@merchant1.name).once
    end
  end

  # 2. Merchant Dashboard Links
  it "has links to the merchant items index and the invoice items index" do 
    visit merchant_dashboard_path(@merchant1)

    within("div#merchant-header") do
      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
    end
  end

  # 3. Merchant Dashboard Statistics - Favorite Customers
  describe "favorite customers" do
    it "lists names of the 5 customers with the most success transactions" do
      visit merchant_dashboard_path(@merchant1)

      within("div#favorite-customers") do
        expect(page).to have_content(@customer1.full_name).once
        expect(page).to have_content(@customer2.full_name).once
        expect(page).to have_content(@customer3.full_name).once
        expect(page).to have_content(@customer4.full_name).once
        expect(page).to have_content(@customer5.full_name).once
        expect(page).to_not have_content(@customer8.full_name).once
        expect(@customer1.full_name).to appear_before(@customer2.full_name)

      end
    end

    it "lists the number of successful transactions for the favorite customers" do
      visit merchant_dashboard_path(@merchant1)

      within("div#favorite-customers") do
        expect(page).to have_content("- 2 purchases")
        expect(page).to have_content("- 1 purchases", count: 4)
      end
    end
  end
end