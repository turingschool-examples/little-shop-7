require "rails_helper"

RSpec.describe "Merchant Show Page" do
  describe "Dashboard" do
    # US_1
    it "Displays the name of the merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      visit merchant_path(merchant)
      expect(page).to have_content(merchant.name)
    end

  # US_2
  describe "User Story 2" do
    it "I see a link to my merchant items index" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      
      visit merchant_path(merchant)
      
      expect(page).to have_link("Items")
      expect(page).to have_link("Invoices")
    end
  end

    # US_3
  describe "User Story 3 - I see merchant stats" do
    it "shows top 5 customers with successful transactions" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customers = create_list(:customer, 10)
    
      customers.each do |customer|
        rand(1..5).times do
          invoice = create(:invoice, customer: customer)
          invoice_item = create(:invoice_item, :shipped, item: item, invoice: invoice)
          transaction_results = ["success", "failed"]
          result = transaction_results.sample
          create(:transaction, result: result, invoice: invoice)
        end
      end
      
      visit merchant_path(merchant)
      
      top_customers = merchant.top_five_customers
      
        within "#top_five_customers" do 
          top_customers.each do |customer|  
            expect(page).to have_content(customer.first_name)
            expect(page).to have_content(customer.transaction_count)
          end
        end
      end
    end

      #US_4 & 5
    describe "ready to ship section" do
      it "shows a list of items ready to ship from oldest to newest" do
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
        
        visit merchant_path(merchant)
        
        merchant_pending_items = merchant.pending_items
        
        within "#item" do
            merchant_pending_items.each do |item|
            invoice = item.invoices.first
            expect(page).to have_content(item.name)
            expect(page).to have_content(invoice.id)
            expect(page).to have_link("Invoice #{item.invoices.first.id}")
            expect(page).to have_content(invoice.created_at.strftime("%A, %B %d, %Y"))
          end
        end
      end
    end
    describe "api consumption" do
      it "shows a random image from unsplash" do
        merchant = create(:merchant)

        visit merchant_path(merchant)

        within ".random_image" do
          expect(page).to have_css("img[src]")
        end
      end
    end
  end
end
