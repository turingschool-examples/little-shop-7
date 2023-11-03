require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merchant1 = create(:merchant, name: "CamelsRUs")
    @merchant2 = create(:merchant, name: "Pickle Store Depot")

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id, enable: false)
    @item4 = create(:item, merchant_id: @merchant2.id)
    @item5 = create(:item)
  end

  describe 'as a merchant' do
    describe 'when I visit merchant items index page /merchants/:merchant_id/items' do
      it 'shows the list of items name' do
        #US 6
        visit "/merchants/#{@merchant1.id}/items"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@merchant2.name)
      end

      it 'when I click on an item, it takes to the the show page' do
        #US 7
        visit "/merchants/#{@merchant1.id}/items"

        click_on "#{@item1.name}"

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

        expect(page).to have_content("Item Name: #{@item1.name}")
        expect(page).to have_content("Item Description: #{@item1.description}")
        expect(page).to have_content("Item Unit Price: #{@item1.unit_price}")
      end

      it 'has a button to enable item' do
        #US 9
        visit "/merchants/#{@merchant1.id}/items"

        within("#enabled_item-#{@item1.id}") do
          expect(page).to have_button("Disable")
        end
        
        within("#enabled_item-#{@item2.id}") do
          expect(page).to have_button("Disable")
          click_button "Disable"
          expect(page).to_not have_content(@item2.name)
        end

        within("#disabled_item-#{@item3.id}") do
          expect(page).to have_button("Enable")
          click_button "Enable"
          expect(page).to_not have_content(@item3.name)
        end
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      end

      it 'shows two sections, enabled items and disabled items and items listed appropriately' do
        #US 10
        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("Disabled Items")
        expect(@item1.name).to appear_before("Disabled Items")
        expect(@item2.name).to appear_before("Disabled Items")
        expect("Disabled Items").to appear_before(@item3.name)
      end

      it 'has a link to create a new item and add to index' do
        #US 11
        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_link("Create a new item")

        click_link("Create a new item")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

        expect(page).to have_field("Item Name")
        expect(page).to have_field("Item Description")
        expect(page).to have_field("Item Unit Price")

        fill_in("Item Name", with: "Jerky")
        fill_in("Item Description", with: "Jerky for energy")
        fill_in("Item Unit Price", with: 10)

        click_button("Submit")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("Jerky")
      end
    end
  end
end