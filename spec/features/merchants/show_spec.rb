require "rails_helper"

RSpec.describe "Merchant Dashboard Index Page" do 
  before(:each) do 
    @merchant = create(:merchant)
  end

  describe "Merchant Dashboard Display" do 
    #User Story 1
    it "displays the name of the merchant" do 
      visit merchant_dashboard_path(@merchant) 

      expect(page).to have_content(@merchant.name)
    end

    #user story 2
    it "displays links to merchant items index and merchant invoices index" do 
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_link("Items Index")
      expect(page).to have_link("Invoices Index")
    end
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    #user story 3
    it "displays the names of the top 5 customers and number of successful transactions" do 
      @item_1 = create(:item, merchant: @merchant)

      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)

      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer: @customer_2)
      @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
      @transaction_3 = create(:transaction, result: "success", invoice: @invoice_2)

      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer: @customer_3)
      @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
      @transaction_4 = create(:transaction, result: "success", invoice: @invoice_3)
      @transaction_5 = create(:transaction, result: "success", invoice: @invoice_3)
      @transaction_6 = create(:transaction, result: "success", invoice: @invoice_3)

      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, customer: @customer_4)
      @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id)
      @transaction_7 = create(:transaction, result: "success", invoice: @invoice_4)
      @transaction_8 = create(:transaction, result: "success", invoice: @invoice_4)

      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, customer: @customer_5)
      @invoice_item_5 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id)
      @transaction_9 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_10 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_11 = create(:transaction, result: "success", invoice: @invoice_5)
      @transaction_17 = create(:transaction, result: "success", invoice: @invoice_5)

      @customer_6 = create(:customer)
      @invoice_6 = create(:invoice, customer: @customer_6)
      @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)
      @transaction_12 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_13 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_14 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_15 = create(:transaction, result: "success", invoice: @invoice_6)
      @transaction_16 = create(:transaction, result: "success", invoice: @invoice_6)
      
      visit merchant_dashboard_path(@merchant)
      
      expect(page).to have_content("Top Five Customers")

      within "#top_customers"
      save_and_open_page
      expect(page).to have_content(@customer_6.first_name)
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to_not have_content(@customer_1.first_name)

      expect(@customer_6.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_5.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_2.first_name)
    end
  end
end