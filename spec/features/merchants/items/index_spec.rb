require "rails_helper"

RSpec.describe "/merchants/:merchant_id/items" do
  describe "As a visitor" do
    describe "when I visit a merchants items index page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:customer_1) { create(:customer) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_2) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 900000, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: 900000, quantity: 1) }

      let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_3) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_4) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 300000, quantity: 1) }
      let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_4, item: item_2, unit_price: 300000, quantity: 1) }

      let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_5) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_6) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_5, item: item_3, unit_price: 600000, quantity: 1) }
      let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_6, item: item_3, unit_price: 600000, quantity: 1) }

      let!(:item_4) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_7) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_8) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_7, item: item_4, unit_price: 12, quantity: 1) }
      let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_8, item: item_4, unit_price: 12, quantity: 1) }

      let!(:item_5) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_9) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_10) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_9) { create(:invoice_item, invoice: invoice_9, item: item_5, unit_price: 10000, quantity: 1) }
      let!(:invoice_item_10) { create(:invoice_item, invoice: invoice_10, item: item_5, unit_price: 10000, quantity: 1) }

      let!(:item_6) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_11) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_12) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_11) { create(:invoice_item, invoice: invoice_11, item: item_6, unit_price: 1200000, quantity: 1) }
      let!(:invoice_item_12) { create(:invoice_item, invoice: invoice_12, item: item_6, unit_price: 1200000, quantity: 1) }

      let!(:transaction_1) { create(:transaction, invoice: invoice_1, result: 0) }
      let!(:transaction_2) { create(:transaction, invoice: invoice_2, result: 0) }
      let!(:transaction_3) { create(:transaction, invoice: invoice_3, result: 0) }
      let!(:transaction_4) { create(:transaction, invoice: invoice_4, result: 0) }
      let!(:transaction_5) { create(:transaction, invoice: invoice_5, result: 0) }
      let!(:transaction_6) { create(:transaction, invoice: invoice_6, result: 0) }
      let!(:transaction_7) { create(:transaction, invoice: invoice_7, result: 0) }
      let!(:transaction_8) { create(:transaction, invoice: invoice_8, result: 0) }
      let!(:transaction_9) { create(:transaction, invoice: invoice_9, result: 0) }
      let!(:transaction_10) { create(:transaction, invoice: invoice_10, result: 0) }
      let!(:transaction_11) { create(:transaction, invoice: invoice_11, result: 0) }
      let!(:transaction_12) { create(:transaction, invoice: invoice_12, result: 0) }

      let!(:item_6) { create(:item, merchant_id: merchant_2.id, status: 0)}
      let!(:item_7) { create(:item, merchant_id: merchant_1.id, status: 0)}

      # User Story 6 - Merchant Items Index Page

      it "displays a list of names of all that merchants items" do
        visit "/merchants/#{merchant_1.id}/items"

        within ".enabled-items" do
          expect(page).to have_content(item_1.name)
          expect(page).to have_content(item_2.name)
          expect(page).to have_content(item_3.name)
          expect(page).to have_content(item_4.name)
          expect(page).to have_content(item_5.name)

          expect(page).to_not have_content(item_6.name)
        end

        visit "/merchants/#{merchant_2.id}/items"
        within ".disabled-items" do
          expect(page).to have_content(item_6.name)
          expect(page).to_not have_content(item_1.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_3.name)
        end
      end

      # User Story 7 - Merchant Items Show Page (links from index)

      it "links to the items show page when I click on the item name" do
        visit "/merchants/#{merchant_1.id}/items"
        within ".enabled-items" do
          click_link "#{item_1.name}"
        end
          expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
          expect(current_path).to_not eq("/merchants/#{merchant_1.id}/items/#{item_2.id}")

        visit "/merchants/#{merchant_1.id}/items"
        within ".disabled-items" do
          click_link "#{item_7.name}"
        end
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_7.id}")
      end

      # User Story 9/10 - Merchant Item Disable/Enable

      it "displays a button that will enable or disable each item" do
        visit "/merchants/#{merchant_1.id}/items"
        within ".enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to have_link(item_2.name)
          expect(page).to have_link(item_3.name)

          expect(page).to have_button("Disable #{item_1.name}")
          expect(page).to have_button("Disable #{item_2.name}")
          expect(page).to have_button("Disable #{item_3.name}")

          click_button "Disable #{item_1.name}"
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within ".disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to have_link(item_7.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_3.name)

          expect(page).to have_button("Enable #{item_1.name}")
          expect(page).to have_button("Enable #{item_7.name}")
          expect(page).to_not have_button("Disable #{item_2.name}")
          expect(page).to_not have_button("Disable #{item_3.name}")

          click_button "Enable #{item_7.name}"

        end

        within ".enabled-items" do
          expect(page).to_not have_link(item_1.name)
          expect(page).to_not have_button("Disable #{item_1.name}")

          expect(page).to have_link(item_7.name)
          expect(page).to have_button("Disable #{item_7.name}")
        end
      end

      # User Story 11 - Merchant Item Create (link)

      it "has a link to create a new item" do
        visit "/merchants/#{merchant_1.id}/items"
        click_link "Create New Item"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
      end

    #  User Story 12 - Merchant Items Index: 5 most popular items
    #   As a merchant
    #   When I visit my items index page
    #   Then I see the names of the top 5 most popular items ranked by total revenue generated
    #   And I see that each item name links to my merchant item show page for that item
    #   And I see the total revenue generated next to each item name

    #   Notes on Revenue Calculation:

    #   Only invoices with at least one successful transaction should count towards revenue
    #   Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    #   Revenue for an invoice item should be calculated as the invoice item unit price multiplied
    #   by the quantity (do not use the item unit price)

      it "displays the top 5 most popular items ranked by total revenue for the one merchant" do
        visit "/merchants/#{merchant_1.id}/items"
        within ".top-five-items" do
          expect(page).to have_content("Top 5 Items")

          expect(page).to have_content("#{item_6.name} - $24,000.00 in sales")
          expect(page).to have_content("#{item_1.name} - $18,000.00 in sales")
          expect(page).to have_content("#{item_3.name} - $12,000.00 in sales")
          expect(page).to have_content("#{item_2.name} - $6,000.00 in sales")
          expect(page).to have_content("#{item_5.name} - $200.00 in sales")
          expect(page).to_not have_content("#{item_4.name} - $24.00 in sales")
        end
      end

      it "displays a link with each name of the top merchants by revenue" do
        visit "/merchants/#{merchant_1.id}/items"

        within ".top-five-items" do
          expect(page).to have_link("#{item_1.name}")
          expect(page).to have_link("#{item_2.name}")
          expect(page).to have_link("#{item_3.name}")
          expect(page).to have_link("#{item_5.name}")
          expect(page).to have_link("#{item_6.name}")

          expect(page).to_not have_link("#{item_4.name}")

          click_link("#{item_1.name}")
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
      end
    end
  end
end