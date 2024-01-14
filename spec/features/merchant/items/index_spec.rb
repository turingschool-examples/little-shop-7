require "rails_helper"

RSpec.describe "MerchantItem index", type: :feature do
	it "User Story 6. Merchant Items Index Page" do
		@merchant_1 = Merchant.create(name: "Chucky Cheese")
		@merchant_2 = Merchant.create(name: "McDonalds")
		@item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)
		@item_2 = @merchant_2.items.create(name: "Big Mac", description: "Juicy", unit_price: 29, merchant_id: @merchant_2.id)
		@item_3 = @merchant_2.items.create(name: "Chicken Nuggets", description: "Vegan", unit_price: 15, merchant_id: @merchant_2.id)

		# When I visit my merchant items index page (merchants/:merchant_id/items)
		visit "/merchants/#{@merchant_1.id}/items"
		# I see a list of the names of all of my items
		expect(page).to have_content("Merchant Item List")
		expect(page).to have_content("Chucky Cheese's items")
		# expect(page).to have_content("cookie")
		expect(page).to have_content("Moldy Cheese")
		# And I do not see items for any other merchant
		expect(page).to_not have_content("Big Mac")
	end

	it "10. Merchant Items Grouped by Status" do
		@merchant_1 = Merchant.create(name: "Chucky Cheese")
		@merchant_2 = Merchant.create(name: "McDonalds")
		@item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)
		@item_2 = @merchant_2.items.create(name: "Big Mac", description: "Juicy", unit_price: 29, merchant_id: @merchant_2.id)
		@item_3 = @merchant_2.items.create(name: "Chicken Nuggets", description: "Vegan", unit_price: 15, merchant_id: @merchant_2.id)
		# When I visit my merchant items index page
		visit "/merchants/#{@merchant_2.id}/items"
		# Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
		within '.enabled-items' do
				expect(page).to have_content("Enabled Items")
		end
		within '.disabled-items' do
				expect(page).to have_content("Disabled Items")
		end
		# And I see that each Item is listed in the appropriate section
		within '.enabled-items' do
				expect(page).to_not have_content("Big Mac")
				expect(page).to_not have_content("Chicken Nuggets")
		end
		within '.disabled-items' do
			expect(page).to have_content("Big Mac")
			expect(page).to have_content("Chicken Nuggets")

			within "#item-#{@item_2.id}" do
					click_on("Enable/Disable")
			end
		end

		within '.enabled-items' do
			expect(page).to have_content("Big Mac")
			expect(page).to_not have_content("Chicken Nuggets")
		end
		within '.disabled-items' do
			expect(page).to_not have_content("Big Mac")
			expect(page).to have_content("Chicken Nuggets")
		end
	end

	it "shows a merchant's top 5 most popular items ranked by total revenue generated" do 
		load_data

		visit "/merchants/#{@merchant.id}/items"
		
		within ".top-5-rev" do 
			expect(@items[4].name).to appear_before(@items[2].name)
			expect(@items[2].name).to appear_before(@items[0].name)
			expect(@items[0].name).to appear_before(@items[1].name)
			expect(@items[1].name).to appear_before(@items[3].name)
		end
	end

	it "next to each of the five top-selling items is the date with the most sales revenue for that item" do 
		load_data

		visit "/merchants/#{@merchant.id}/items"
		
		top_5 = @merchant.items.top_5_by_revenue
		top_5.each do |item| 
			within "#top-item-#{item.id}" do 
				expect(page).to have_content(item.top_selling_date.sale_date.strftime('%A, %B %d, %Y'))
			end
		end
	end

	it "next to each top-5 item it displays a singular date that particular item generated the most revenue" do 
		load_data

		visit "/merchants/#{@merchant.id}/items"

		top_5 = @merchant.items.top_5_by_revenue
		top_5.each do |item| 
			within "#top-item-#{item.id}" do 
				expect(page).to have_content(
					"Top selling date for #{item.name} was #{item.top_selling_date.sale_date.strftime('%A, %B %d, %Y')}"
					)
			end
		end
	end
end