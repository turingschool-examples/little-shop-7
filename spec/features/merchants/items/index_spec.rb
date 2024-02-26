require "rails_helper"

RSpec.describe "merchant index" do
  before(:each) do
    @customer1 = Customer.create(first_name: "Martin", last_name: "Chavez")
    @customer2 = Customer.create(first_name: "Rodrigo", last_name: "Alberto")

    
    @merchant1 = Merchant.create(name: "Merchant A")
    @merchant2 = Merchant.create(name: "Merchant B")

    
    @item1 = Item.create(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
    @item2 = Item.create(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
    @item3 = Item.create(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2)
    @item4 = Item.create(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2)

    
    @invoice1 = Invoice.create(status: 1, customer: @customer1)
    @invoice2 = Invoice.create(status: 1, customer: @customer2)

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 2, unit_price: 2000, status: 1)
    @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 3, unit_price: 4000, status: 1)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: 0)
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: "9876543210987654", credit_card_expiration_date: "09/24", result: 1)

  end

  describe 'US 6' do
   describe 'Merchant Items Index Page' do
     it 'displays list of the names of all of my items And I do not see items for any other merchant' do
       visit merchant_items_path(@merchant1)
        # When I visit my merchant items index page (merchants/:merchant_id/items)
        expect(page).to have_content('Merchant Name: Merchant A')

        expect(page).to have_content('Item name: Gum')
        expect(page).to have_content('Item name: Mint')
        # I see a list of the names of all of my items

        expect(page).to_not have_content('Apple')
        expect(page).to_not have_content('orange')
        # And I do not see items for any other merchant
     end
   end
  end

  describe 'US 7' do
    it 'has a link for an item and takes it to an item show page and see all of the items attributes' do
      visit merchant_items_path(@merchant1)

      click_link(@item1.name)

      expect(current_path).to eq(merchant_item_path(@merchant1,@item1))

      expect(page).to have_content('Item Name: Gum')
      expect(page).to have_content('Description: Description for Item 1')
      expect(page).to have_content('Unit Price: 1000')

      expect(page).to_not have_content('Item Name: Mint')

    end
  end

  describe 'US 9' do
    it 'changes the status of an item' do
      visit merchant_items_path(@merchant1)

      within("#item-#{@item1.id}") do
        expect(page).to have_content('Gum')
        # Next to each item name I see a button to disable or enable that item.
        expect(page).to have_button("Disable")
        # When I click this button
        click_button("Disable")
        expect(page).to have_content('Status: disabled')
      end

    end
  end

  describe 'US 10' do
    it 'has a button to disable or enable an item' do

      visit merchant_items_path(@merchant1)
      # When I visit my items index page (/merchants/:merchant_id/items)
      within ".enabled_items" do 
        within("#item-#{@item1.id}") do
          expect(page).to have_content('Gum')
          # Next to each item name I see a button to disable or enable that item.
          expect(page).to have_button("Disable")
          # When I click this button
          click_button("Disable")
        end
      end
      # save_and_open_page
      # Then I am redirected back to the items index
      expect(current_path).to eq(merchant_items_path(@merchant1))
      # And I see that the items status has changed
      within ".disabled_items" do 
        within("#item-#{@item1.id}") do
          expect(page).to have_content('Gum')
          expect(page).to have_content('Status: disabled')
          # Next to each item name I see a button to disable or enable that item.
          expect(page).to have_button("Enable")
        end
      end
    end


    it 'has a button to disable or enable an item' do
      item_disabled = Item.create(name: "Bannans", description: "This item is disabled", unit_price: 200, merchant: @merchant1, status:1)
      
      visit merchant_items_path(@merchant1)
      # save_and_open_page
      # When I visit my items index page (/merchants/:merchant_id/items)
      within ".disabled_items" do 
        within("#item-#{item_disabled.id}") do
          expect(page).to have_content('Bannans')
          expect(page).to have_button("Enable")
          click_button("Enable")
        end
      end 
      # Next to each item name I see a button to disable or enable that item.
     
      
      # When I click this button

      expect(current_path).to eq(merchant_items_path(@merchant1))
      # Then I am redirected back to the items index
     
      within(".enabled_items") do
        within("#item-#{item_disabled.id}") do
          expect(page).to have_content('Bannans')
          expect(page).to have_content('Status: enabled')
          expect(page).to have_button("Disable")

        end
      end
      # And I see that the items status has changed
     
    end
  end

  describe 'US 11' do
    it 'creates a merchant item' do
      merchant_without_item =  Merchant.create!(name: "Merchant without Items")
      visit merchant_items_path(merchant_without_item)
      # I see a link to create a new item.
      expect(page).to have_link("New Item")
      click_link("New Item")
      # When I click on the link,
      
      expect(current_path).to eq(new_merchant_item_path(merchant_without_item))
      # I am taken to a form that allows me to add item information.
      
      fill_in :name, with: "Chips"
      fill_in :description, with: "Chips description"
      fill_in :unit_price, with: 4000
      click_on("Submit")
      
      
      # When I fill out the form I click ‘Submit’
      
      expect(current_path).to eq( merchant_items_path(merchant_without_item))
      # Then I am taken back to the items index page
      
      
      
      # save_and_open_page
      expect(page).to have_content('Chips')
      # And I see the item I just created displayed in the list of items.
      expect(page).to have_content('Status: disabled')
      expect(page).to have_content("Item created!!")
      # And I see my item was created with a default status of disabled.

    end
  end


end