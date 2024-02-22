require 'rails_helper'

RSpec.describe 'Admin Dashboard (Index)', type: :feature do
  describe 'As an admin' do
    before(:each) do
      # @customers = create_list(:customer, 10)
      # @customer_1 = @customers[0]
      # @customer_2 = @customers[1]
      # @customer_3 = @customers[2]
      # @customer_4 = @customers[3]
      # @customer_5 = @customers[4]
      # @customer_6 = @customers[5]
      # @customer_7 = @customers[6]
      # @customer_8 = @customers[7]
      # @customer_9 = @customers[8]
      # @customer_10 = @customers[9]
      # @invoice_1 = @customer_1.invoices[0]
      # @invoice_2 = @customer_1.invoices[1]
      # @invoice_3 = @customer_1.invoices[2]
      # @invoice_4 = @customer_1.invoices[3]
      # @invoice_5 = @customer_1.invoices[4]
      # @invoice_6 = @customer_2.invoices[0]
      # @invoice_7 = @customer_2.invoices[1]
      # @invoice_8 = @customer_2.invoices[2]
      # @invoice_9 = @customer_2.invoices[3]
      # @invoice_10 = @customer_2.invoices[4]
      # @invoice_11 = @customer_3.invoices[0]
      # @invoice_12 = @customer_3.invoices[1]
      # @invoice_13 = @customer_3.invoices[2]
      # @invoice_14 = @customer_3.invoices[3]
      # @invoice_15 = @customer_3.invoices[4]
      # @invoice_16 = @customer_4.invoices[0]
      # @invoice_17 = @customer_4.invoices[1]
      # @invoice_18 = @customer_4.invoices[2]
      # @invoice_19 = @customer_4.invoices[3]
      # @invoice_20 = @customer_4.invoices[4]
      # @invoice_21 = @customer_5.invoices[0]
      # @invoice_22 = @customer_5.invoices[1]
      # @invoice_23 = @customer_5.invoices[2]
      # @invoice_24 = @customer_5.invoices[3]
      # @invoice_25 = @customer_5.invoices[4]
      # @invoice_26 = @customer_5.invoices.create!(status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      # @invoice_27 = @customer_5.invoices.create!(status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
      # @invoice_28 = @customer_5.invoices.create!(status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")

      # @merchants = create_list(:merchant, 10)
      # @merchant_1 = @merchants[0]
      # @merchant_2 = @merchants[1]
      # @merchant_3 = @merchants[2]
      # @merchant_4 = @merchants[3]
      # @merchant_5 = @merchants[4]
      # @merchant_6 = @merchants[5]
      # @merchant_7 = @merchants[6]
      # @merchant_8 = @merchants[7]
      # @merchant_9 = @merchants[8]
      # @merchant_10 = @merchants[9]
      # @item_1 = @merchant_1.items[0]
      # @item_2 = @merchant_1.items[1]
      # @item_3 = @merchant_1.items[2]
      # @item_4 = @merchant_1.items[3]
      # @item_5 = @merchant_1.items[4]

      # @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
      # @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
      # @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 1300, status: 1)
      # @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: 1300, status: 2)
      # @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1300, status: 2)
      # @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_26.id, quantity: 1, unit_price: 1300, status: 0)
      # @invoice_item_7 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_27.id, quantity: 1, unit_price: 1300, status: 0)
      # @invoice_item_8 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_28.id, quantity: 1, unit_price: 1300, status: 0)


      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id)
      @invoice_7 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_8 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_9 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")

      @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_2 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_3 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_4 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_5 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_6 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_7 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_8 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_9 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_10 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_11 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_12 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_13 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_14 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_15 = create(:transaction, invoice_id: @invoice_5.id)
      

      @merchant_1 = create(:merchant, name: "Amazon") 

      @item_1 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_3 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_4 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_5 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)

      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 1300, status: 1)
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: 1300, status: 2)
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1300, status: 2)
      @invoice_item_6 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_8 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: 1300, status: 0)

    end

    #User Story 19
    it 'displays the admin dashboard header' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path
      
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")
    end

    #User Story 20. Admin Dashboard Links
    it 'displays links to admin merchants and invoices index' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path

      # Then I see a link to the admin merchants index (/admin/merchants)
      expect(page).to have_link(href: "/admin/merchants")

      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link(href: "/admin/invoices")
    end

    #User Story 21. Admin Dashboard Statistics - Top Customers
    it 'displays the names of the top 5 customers and the number of successful transactions they have conducted' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path

      within "#top_customers" do
        expect(page).to have_content("Top Customers")
        # Then I see the names of the top 5 customers
        within "#top_customer#{@customer_1.id}" do
          # who have conducted the largest number of successful transactions
          expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
          # And next to each customer name I see the number of successful transactions they have conducted
          expect(page).to have_content("5 purchases")
        end

        within "#top_customer#{@customer_2.id}" do
          expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
          expect(page).to have_content("4 purchases")
        end

        within "#top_customer#{@customer_3.id}" do
          expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
          expect(page).to have_content("3 purchases")
        end

        within "#top_customer#{@customer_4.id}" do
          expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
          expect(page).to have_content("2 purchases")
        end

        within "#top_customer#{@customer_5.id}" do
          expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
          expect(page).to have_content("1 purchases")
        end
      end
    end


    # User Story 22. Admin Dashboard Incomplete Invoices
    it 'has a section that shows all incomplete invoices with their invoice ids and links to each invoices admin-show page' do
      # As an admin, When I visit the admin dashboard (/admin)
      visit admin_index_path
      # Then I see a section for "Incomplete Invoices"
      within ".incomplete_invoices" do
        expect(page).to have_content("Incomplete Invoices")
        # In that section I see a list of the ids of all invoices
        # That have items that have not yet been shipped
        # And each invoice id links to that invoice's admin show page
        within "#invoice_#{@invoice_7.id}" do
          expect(page).to have_content("Invoice ##{@invoice_7.id}")
          expect(page).to have_link(:href => "/admin/invoices/#{@invoice_7.id}")
        end

        within "#invoice_#{@invoice_8.id}" do
          expect(page).to have_content("Invoice ##{@invoice_8.id}")
          expect(page).to have_link(:href => "/admin/invoices/#{@invoice_8.id}")
        end

        within "#invoice_#{@invoice_9.id}" do
          expect(page).to have_content("Invoice ##{@invoice_9.id}")
          expect(page).to have_link(:href => "/admin/invoices/#{@invoice_9.id}")
        end

        expect(page).not_to have_content(@invoice_4.id)
        expect(page).not_to have_content(@invoice_5.id)
      end
    end

    # User Story 23. Admin Dashboard Invoices sorted by least recent
    it 'will display the date that the incomplete invoice was created and sorts them by oldest to newest' do
      # As an admin, When I visit the admin dashboard (/admin)
      visit admin_index_path

      # In the section for "Incomplete Invoices",
      within ".incomplete_invoices" do
        # Next to each invoice id I see the date that the invoice was created
        # And I see the date formatted like "Monday, July 18, 2019"
        # And I see that the list is ordered from oldest to newest
        expect("Invoice ##{@invoice_9.id} - Monday, February 19, 2024").to appear_before("Invoice ##{@invoice_8.id} - Tuesday, February 20, 2024")
        expect("Invoice ##{@invoice_8.id} - Tuesday, February 20, 2024").to appear_before("Invoice ##{@invoice_7.id} - Wednesday, February 21, 2024")
      end
    end
  end
end