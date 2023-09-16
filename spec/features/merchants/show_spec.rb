require "rails_helper"

RSpec.describe "merchant#show" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 1234)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)
    @item_7 = create(:item, merchant_id: @merchant_2.id)
    @item_8 = create(:item, merchant_id: @merchant_2.id)
    @item_9 = create(:item, merchant_id: @merchant_2.id)

    # @customer_1 = create(:first_name, :last_name)
  end

  describe "display merchant info" do
    it "has merchant info listed " do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
      within("#merchant_info-#{@merchant_1.id}") do 
        expect(page).to have_content(@merchant_1.name)
      end
    end

    it "has links to a merchant's items and invoices" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#items_index-#{@merchant_1.id}") do
        expect(page).to have_link("Items")
      end
      within("#invoices_index-#{@merchant_1.id}") do
        expect(page).to have_link("Invoices")
      end
    end

    it "shows the top 5 customers with the largest successful transactions with this merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#top_five_customers-#{@merchant_1.id}") do
        expect(page).to have_content([@customer_1.name, @customer_2.name, @customer_3.name, @customer_4.name, @customer_6.name])
        expect(page).to have_content([@customer_1.amount_of_transactions, @customer_2.amount_of_transactions, @customer_3.amount_of_transactions, @customer_4.amount_of_transactions, @customer_6.amount_of_transactions])
      end
    end
  end
end