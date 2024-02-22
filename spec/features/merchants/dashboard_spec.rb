require 'rails_helper'

RSpec.describe 'merchants dashboard', type: :feature do
  describe 'As a merchant' do
    before(:each) do
      @cust_1 = create(:customer)
      @cust_2 = create(:customer)
      @cust_3 = create(:customer)
      @cust_4 = create(:customer)
      @cust_5 = create(:customer)
      @cust_6 = create(:customer)
      
      @invoice_1 = create(:invoice, customer_id: @cust_1.id)
      @invoice_2 = create(:invoice, customer_id: @cust_2.id)
      @invoice_3 = create(:invoice, customer_id: @cust_3.id)
      @invoice_4 = create(:invoice, customer_id: @cust_4.id)
      @invoice_5 = create(:invoice, customer_id: @cust_5.id)
      @invoice_6 = create(:invoice, customer_id: @cust_6.id)
      
      @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_2 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_3 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_4 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_5 = create(:transaction, invoice_id: @invoice_5.id)
      @trans_6 = create(:transaction, invoice_id: @invoice_6.id)
      
      @merch_1 = create(:merchant, name: "Amazon") 

      @item_1 = create(:item, unit_price: 1, merchant_id: @merch_1.id)

      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1, quantity: 100)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: 1, quantity: 80)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, unit_price: 1, quantity: 60)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id, unit_price: 1, quantity: 50)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id, unit_price: 1, quantity: 40)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id, unit_price: 1, quantity: 5)
    end

    # 1. Merchant Dashboard
    it 'displays merchant name' do
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      visit dashboard_merchant_path(@merch_1)
      # Then I see the name of my merchant
      within '.merchant-info' do
        expect(page).to have_content(@merch_1.name)
      end
    end
    
    # 2. Merchant Dashboard Links
    it 'has clickable links' do
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      visit dashboard_merchant_path(@merch_1)

      within '.links' do 
        # Then I see link to my merchant items index (/merchants/:merchant_id/items)
        expect(page).to have_link("Merchant Items")
        # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
        expect(page).to have_link("Merchant Invoice Items")
      end
    end

    # 3. Merchant Dashboard Statistics - Favorite Customers
    it "displays top customers and their successful transation count" do 
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      visit dashboard_merchant_path(@merch_1.id)
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions with my merchant
      within '.top-five' do
        # And next to each customer name I see the number of successful transactions they have conducted with my merchant
        within "#customer-#{@cust_1.id}" do
          expect(page).to have_content("#{@cust_1.first_name} #{@cust_1.last_name}")
          expect(page).to have_content("Successful Transaction(s): 1")
        end
        within "#customer-#{@cust_2.id}" do
          expect(page).to have_content("#{@cust_2.first_name} #{@cust_2.last_name}")
          expect(page).to have_content("Successful Transaction(s): 1")
        end
        within "#customer-#{@cust_3.id}" do
          expect(page).to have_content("#{@cust_3.first_name} #{@cust_3.last_name}")
          expect(page).to have_content("Successful Transaction(s): 1")
        end
        within "#customer-#{@cust_4.id}" do
          expect(page).to have_content("#{@cust_4.first_name} #{@cust_4.last_name}")
          expect(page).to have_content("Successful Transaction(s): 1")
        end
        within "#customer-#{@cust_5.id}" do
          expect(page).to have_content("#{@cust_5.first_name} #{@cust_5.last_name}")
          expect(page).to have_content("Successful Transaction(s): 1")
        end
      end

      it "" do 
        
      end
    end
  end
end