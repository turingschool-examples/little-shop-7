require 'rails_helper'

RSpec.describe 'merchant item show', type: :feature do
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

    # 7. Merchant Items Show Page
    it 'links to item show page' do
      # As a merchant,
      visit merchant_items_path(@merch_1)
      # When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
      click_link(@item_1.name)
      # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
      expect(current_path).to eq(merchant_item_path(@merch_1, @item_1))
      # And I see all of the item's attributes including:
      # - Name
      # - Description
      # - Current Selling Price
      within '.items-attributes' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content(@item_1.unit_price)
      end
    end

    # 8. Merchant Item Update
    it "can update item info" do
      # As a merchant,
      # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
      visit merchant_item_path(@merch_1, @item_1)
      # I see a link to update the item information.
      expect(page).to have_link("Update Item Information")
      # When I click the link
      click_link("Update Item Information")
      # Then I am taken to a page to edit this item
      expect(current_path).to eq(edit_merchant_item_path(@merch_1, @item_1))
      # And I see a form filled in with the existing item attribute information
      fill_in "name", with: "Larry"
      fill_in "description", with: "Hello"
      fill_in "unit_price", with: "4"
      
      # When I update the information in the form and I click ‘submit’
      click_on "Submit"
      # Then I am redirected back to the item show page where I see the updated information
      expect(current_path).to eq(merchant_item_path(@merch_1, @item_1))
      expect(page).to have_content("Larry")
      expect(page).to have_content("Hello")
      expect(page).to have_content("4")
      # And I see a flash message stating that the information has been successfully updated.
      expect(page).to have_content("Update successful")
    end
  end
end