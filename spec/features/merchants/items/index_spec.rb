require 'rails_helper'

RSpec.describe 'merchant items index', type: :feature do
  describe 'as a merchant' do
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
      @invoice_5 = create(:invoice, customer_id: @cust_6.id, created_at: "Thu, 22 Feb 2024 22:05:45.453230000 UTC +00:00")
      @invoice_6 = create(:invoice, customer_id: @cust_5.id, created_at: "Wed, 21 Feb 2024 22:05:45.453230000 UTC +00:00")
      
      @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
      @trans_2 = create(:transaction, invoice_id: @invoice_2.id)
      @trans_3 = create(:transaction, invoice_id: @invoice_3.id)
      @trans_4 = create(:transaction, invoice_id: @invoice_4.id)
      @trans_5 = create(:transaction, invoice_id: @invoice_5.id)
      @trans_6 = create(:transaction, invoice_id: @invoice_6.id)
      
      @merch_1 = create(:merchant, name: "Amazon") 
      @merch_2 = create(:merchant) 

      @item_1 = create(:item, unit_price: 1, merchant_id: @merch_1.id)
      @item_2 = create(:item, unit_price: 1, merchant_id: @merch_2.id)

      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1, quantity: 100, status: 2)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: 1, quantity: 80, status: 2)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, unit_price: 1, quantity: 60, status: 2)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id, unit_price: 1, quantity: 50, status: 2)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id, unit_price: 1, quantity: 40)
      create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id, unit_price: 1, quantity: 5)
    end

    # 6. Merchant Items Index Page
    it 'displays a merchants items' do
      # When I visit my merchant items index page (merchants/:merchant_id/items)
      visit merchant_items_path(@merch_1)
      # I see a list of the names of all of my items
      within '.merch-items' do
        expect(page).to have_content(@item_1.name)
      end
      # And I do not see items for any other merchant
      expect(page).to_not have_content(@item_2.name)
    end

    # 9. Merchant Item Disable/Enable
    it "can enable or disable each item with a button" do 
      # When I visit my items index page (/merchants/:merchant_id/items)
      visit merchant_items_path(@merch_1)

      within "#item-#{@item_1.id}" do
        # Next to each item name I see a button to disable or enable that item.
        expect(page).to have_button("enable")
        expect(page).to_not have_button("disable")
        # When I click this button
        click_button("enable")
      end
      # Then I am redirected back to the items index
      expect(current_path).to eq(merchant_items_path(@merch_1))
      # And I see that the items status has changed
      within "#item-#{@item_1.id}" do
        expect(page).to have_button("disable")
        expect(page).to_not have_button("enable")
      end
    end
  end
end