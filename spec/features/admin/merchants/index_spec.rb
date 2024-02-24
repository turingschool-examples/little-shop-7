require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
  describe 'As an admin' do
    before(:each) do
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
      @trans_16 = create(:transaction, invoice_id: @invoice_6.id)
      @trans_17 = create(:transaction, invoice_id: @invoice_6.id, result: 1)
      @trans_18 = create(:transaction, invoice_id: @invoice_7.id)
      @trans_19 = create(:transaction, invoice_id: @invoice_8.id)
      @trans_20 = create(:transaction, invoice_id: @invoice_9.id, result: 1)
      
      @merchant_1 = create(:merchant, name: "Amazon", status: 0) 
      @merchant_2 = create(:merchant, name: "Walmart", status: 0) 
      @merchant_3 = create(:merchant, name: "Apple", status: 0) 
      @merchant_4 = create(:merchant, name: "Microsoft", status: 0) 
      @merchant_5 = create(:merchant, name: "Petco", status: 1) 
      @merchant_6 = create(:merchant, name: "Aetna", status: 1) 
      @merchant_7 = create(:merchant, name: "Adidas", status: 1) 

      @item_1 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_3 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_4 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
      @item_5 = create(:item, unit_price: 1, merchant_id: @merchant_2.id)
      @item_6 = create(:item, unit_price: 1, merchant_id: @merchant_2.id)
      @item_7 = create(:item, unit_price: 1, merchant_id: @merchant_3.id)
      @item_8 = create(:item, unit_price: 1, merchant_id: @merchant_4.id)
      @item_9 = create(:item, unit_price: 1, merchant_id: @merchant_5.id)
      @item_10 = create(:item, unit_price: 1, merchant_id: @merchant_6.id)

      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
      @invoice_item_3 = create(:invoice_item, item_id: @item_9.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 500, status: 1)
      @invoice_item_4 = create(:invoice_item, item_id: @item_10.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 100, status: 2)
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 78000, status: 2)
      @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: 78000, status: 0)
      @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: 78000, status: 0)
      @invoice_item_8 = create(:invoice_item, item_id: @item_8.id, invoice_id: @invoice_9.id, quantity: 4, unit_price: 5500, status: 0)
    end

    #User Story 24. Admin Merchants Index
    it 'displays the name of each merchant in the system' do
      # As an admin, When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see the name of each merchant in the system
      within ".merchants_info" do
        expect(page).to have_content("Amazon")
        expect(page).to have_content("Walmart")
        expect(page).to have_content("Apple")
        expect(page).to have_content("Microsoft")
      end
    end

    # User Story 27. Admin Merchant Enable/Disable
    it 'displays a button to enable or disable a merchant and when clicked it will change the merchants status and return to the index page with the merchant in its new section' do
      # As an admin, when I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then next to each merchant name I see a button to disable or enable that merchant.
      within ".merchants_info" do
        within "#disabled_merchants" do
          within "#merchant_#{@merchant_1.id}" do
            expect(page).to have_button("Enable")
          end
          within "#merchant_#{@merchant_2.id}" do
            expect(page).to have_button("Enable")
          end
          within "#merchant_#{@merchant_3.id}" do
            expect(page).to have_button("Enable")
            # When I click this button
            click_on "Enable"
          end
        end
        within "#enabled_merchants" do
          within "#merchant_#{@merchant_3.id}" do
            # Then I am redirected back to the admin merchants index
            expect(current_path).to eq(admin_merchants_path)
            # And I see that the merchant's status has changed
            expect(page).to have_button("Disable")
          end
        end
      end
    end

    # User story 28. Admin Merchants Grouped by Status
    it 'shows two separate sections for enabled and disabled merchants and shows the correct merchant names in each section' do
      # As an admin, when I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      
      # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
      
      # And I see that each Merchant is listed in the appropriate section
      within "#enabled_merchants" do
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content(@merchant_6.name)
        expect(page).to have_content(@merchant_7.name)
      end

      within "#disabled_merchants" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_4.name)
      end
    end

    # User story 29. Admin Merchant Create
    it 'shows a link to create a new merchant on the admin merchant index page' do
      # As an admin, when I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # I see a link to create a new merchant.
      expect(page).to have_link("New Merchant", :href=>new_admin_merchant_path)
      # When I click on the link,
      click_link "New Merchant"
      # I am taken to a form that allows me to add merchant information.
      expect(current_path).to eq(new_admin_merchant_path)
      # Continued in spec/features/admin/merchants/new_spec.rb
    end

    # User Story 30.
    it "displays a top5 merchant section, whith names of the merchants as links to their show page, and also shows the total revenue generated next to its name" do
      # As an admin, When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see the names of the top 5 merchants by total revenue generated
      within ".top_merchants" do
      # And I see that each merchant name links to the admin merchant show page for that merchant
        expect(page).to have_content("Top Merchants")

        within "#merchant_#{@merchant_2.id}" do
          expect(page).to have_link(href: admin_merchant_path(@merchant_2.id))
          # And I see the total revenue generated next to each merchant name
          expect(page).to have_content("Walmart - $1,560 in sales")
        end

        within "#merchant_#{@merchant_3.id}" do
          expect(page).to have_link(href: admin_merchant_path(@merchant_3.id))
          # And I see the total revenue generated next to each merchant name
          expect(page).to have_content("Apple - $780 in sales")
        end

        within "#merchant_#{@merchant_5.id}" do
          expect(page).to have_link(href: admin_merchant_path(@merchant_5.id))
          # And I see the total revenue generated next to each merchant name
          expect(page).to have_content("Petco - $150 in sales")
        end

        within "#merchant_#{@merchant_1.id}" do
          expect(page).to have_link(href: admin_merchant_path(@merchant_1.id))
          # And I see the total revenue generated next to each merchant name
          expect(page).to have_content("Amazon - $117 in sales")
        end

        within "#merchant_#{@merchant_6.id}" do
          expect(page).to have_link(href: admin_merchant_path(@merchant_6.id))
          # And I see the total revenue generated next to each merchant name
          expect(page).to have_content("Aetna - $4 in sales")
        end

        expect(page).not_to have_content("Microsoft")
      end
      # Notes on Revenue Calculation:
      
      # Only invoices with at least one successful transaction should count towards revenue
      # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    end
  end
end