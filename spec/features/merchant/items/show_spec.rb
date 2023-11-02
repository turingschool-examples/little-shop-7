require 'rails_helper'

RSpec.describe 'Merchant item update' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
  end

  describe 'as a merchant' do
    describe 'when I visit merchants show page of an item (/merchants/:merchant_id/items/:item_id)' do
      it 'has a button to update item info' do
        #US 8
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

        expect(page).to have_link("Update Item")

        click_link "Update Item"

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      end

      it 'enables the update and redirects to the show page with message' do
        #US 8
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"

        expect(page).to have_field("Item Name", with: @item1.name)
        expect(page).to have_field("Item Description", with: @item1.description)
        expect(page).to have_field("Item Unit Price", with: @item1.unit_price)

        fill_in("Item Name", with: "Paper")
        fill_in("Item Description", with: "Paper for writing")
        fill_in("Item Unit Price", with: 10)

        click_button("Submit")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

        expect(page).to have_content("Item Name: Paper")
        expect(page).to have_content("Item Description: Paper for writing")
        expect(page).to have_content("Item Unit Price: 10")
        # expect(page).to have_content("Update successful")
      end
    end

    it 'testing invoices' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, customer_id: customer.id)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
      # require 'pry'; binding.pry
    end
  end
end