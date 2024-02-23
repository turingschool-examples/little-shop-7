require "rails_helper"

RSpec.describe "Dashboard index" do
  before(:each) do
    
    # require 'pry'; binding.pry
    @green_merchant = Merchant.create!(name: "Green Inc")
    @black_merchant = Merchant.create!(name: "Black Inc")
    @brown_merchant = Merchant.create!(name: "Brown Inc")
    
    item1 = FactoryBot.create(:item, name: "table", merchant_id: @green_merchant.id)
    item2 = FactoryBot.create(:item, name: "pen", merchant_id: @green_merchant.id)
    item3 = FactoryBot.create(:item, name: "paper", merchant_id: @green_merchant.id)

    @cust_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
    @cust_2 = create(:customer, first_name: "John", last_name: "Smith")
    @cust_3 = create(:customer, first_name: "Jane", last_name: "Perry") #cust_4 will have 15 successful transactions 
    @cust_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
    @cust_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
    @cust_6 = Customer.create(first_name: "Palm", last_name: "Sir") #cust_6 will have 0  transactions 
    # require 'pry'; binding.pry
    #each customer that is created will have 5 invoices with it plus the ones we created below for example cust_1 has 7 invoices
    #for each  invoice it will have 3 transactions
    # 5 * 3 = 15 transactions from factory when we create a customer
    #2 * 3 = 6 transaction for eac in voice that we created which was invoice6 and invoice1 
    #then created 2 extra transactions for customer 1 for each invoice that we made 
    invoice1 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)  #cust1 = 21
    invoice6 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)
    
    invoice2 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
    invoice7 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)  #cust2 = 24
    invoice8 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
    
    
    invoice3 = FactoryBot.create(:invoice, customer_id: @cust_3.id, status: 1)  #cust_3 = 18
    
    invoice4 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    invoice5 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    invoice9 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)  #cust_5 = 27
    invoice10 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    
    # transaction1 = FactoryBot.create(:transaction, invoice: invoice1, result: 0)
    # transaction2 = FactoryBot.create(:transaction, invoice: invoice2, result: 0)
    # transaction3 = FactoryBot.create(:transaction, invoice: invoice3, result: 0)
    # transaction4 = FactoryBot.create(:transaction, invoice: invoice4, result: 0)
    # transaction5 = FactoryBot.create(:transaction, invoice: invoice5, result: 0)
    # transaction6 = FactoryBot.create(:transaction, invoice: invoice6, result: 0)
    # transaction7 = FactoryBot.create(:transaction, invoice: invoice7, result: 0)
    # transaction8 = FactoryBot.create(:transaction, invoice: invoice8, result: 0)
    # transaction9 = FactoryBot.create(:transaction, invoice: invoice9, result: 0)
    transaction10 = FactoryBot.create(:transaction, invoice: invoice10, result: 1)  #cust_5 = 27 successful transactions and 1 is unsuccessful so it should still give us 27 successful transactions 


    # InvoiceItem.create!(item_id: item1.id, invoice_id:invoice1.id, quantity: 5, unit_price: 1000) #5000
    # InvoiceItem.create!(item_id: item1.id, invoice_id:invoice6.id, quantity: 2, unit_price: 1000) #2000
    # InvoiceItem.create!(item_id: item2.id, invoice_id:invoice6.id, quantity: 2, unit_price: 1000, status: 0) #2000
  end 

  describe 'US1' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(@green_merchant)

      expect(page).to have_content(@green_merchant.name)
    end
  end

  describe 'US 2' do
    it ' link to my merchant items index' do
      visit merchant_dashboard_index_path(@green_merchant)

      expect(page).to have_link('My Items')

      click_link("My Items")

      expect(current_path).to eq(merchant_items_path(@green_merchant))
    end

    it 'link to my merchant invoices index ' do
      visit merchant_dashboard_index_path(@green_merchant)

      expect(page).to have_link('My Invoices')

      click_link("My Invoices")

      expect(current_path).to eq(merchant_invoices_path(@green_merchant))
    
    end
  end

  describe 'US 3' do
    it 'displays top 5 customers' do
      visit merchant_dashboard_index_path(@green_merchant)

      # save_and_open_page
      
      expect(page).to have_content("Top 5 Customers:")
  
      # save_and_open_page
      within "#customer_#{@cust_5.id}" do 
        expect(page).to have_content(@cust_5.first_name)
        expect(page).to have_content("Number of Successful Transactions: 27")
      end

      within "#customer_#{@cust_2.id}" do 
        expect(page).to have_content(@cust_2.first_name)
        expect(page).to have_content("Number of Successful Transactions: 24")
      end

      within "#customer_#{@cust_1.id}" do 
        expect(page).to have_content(@cust_1.first_name)
        expect(page).to have_content("Number of Successful Transactions: 21")
      end

      within "#customer_#{@cust_3.id}" do 
        expect(page).to have_content(@cust_3.first_name)
        expect(page).to have_content("Number of Successful Transactions: 18")
      end

      within "#customer_#{@cust_4.id}" do 
        expect(page).to have_content(@cust_4.first_name)
        expect(page).to have_content("Number of Successful Transactions: 15")
      end

      expect(page).to_not have_content(@cust_6.first_name)
   end
  end
end