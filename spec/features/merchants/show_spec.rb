require "rails_helper"

RSpec.describe "Merchant Show Page" do
  describe "Dashboard" do
    # US_1
    it "Displays the name of the merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      visit "/merchants/#{merchant.id}/dashboard"
      expect(page).to have_content(merchant.name)
    end

  # US_2
  describe "User Story 2" do
    it "I see a link to my merchant items index" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_button("#{merchant.name} Items")
      expect(page).to have_button("#{merchant.name} Invoices")
    end
  end

    # US_3
  describe "User Story 3 - I see merchant stats" do
    it "shows top 5 customers with successful transactions" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customers = create_list(:customer, 20)
    
      customers.each do |customer|
        rand(1..20).times do
          invoice = create(:invoice, customer: customer)
          invoice_item = create(:invoice_item, :shipped, item: item, invoice: invoice)
          transaction_results = ["success", "failed"]
          result = transaction_results.sample
          create(:transaction, result: result, invoice: invoice)
        end
      end
      
      visit "/merchants/#{merchant.id}/dashboard"
      
      top_customers = merchant.top_five_customers
      
        within "#top_five_customers" do 
          top_customers.each do |customer|  
            expect(page).to have_content(customer.first_name)
            expect(page).to have_content(customer.transaction_count)
          end
        end
      end
    end

      #US_4
    describe "ready to ship section" do
      it "shows a list of items ready to ship" do
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        merchant = create(:merchant)
        invoices = Array.new
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_1))
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_2))
        
        invoices[0..1].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 0)
        end
        invoices[2..3].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 1)
        end
        invoices[4..5].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 2)
        end

        visit "/merchants/#{merchant.id}/dashboard"
        save_and_open_page
        within "#item" do
          merchant.pending_items.each do |item|
            invoice = item.invoices.first
            expect(page).to have_content(item.name)
            expect(page).to have_content(invoice.id)
          end
        end
      end
    end
  end
end
