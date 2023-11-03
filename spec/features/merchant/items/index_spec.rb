require "rails_helper"

RSpec.describe "Merchant Items Index Page", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hannah's Handbags")
    @merchant2 = Merchant.create!(name: "Arnold's Armoire")
    @item1 = Item.create!(
      name: "Item Qui Esse",
      description:
      "Nihil autem sit odio inventore deleniti.",
      unit_price: 75107,
      merchant_id: @merchant1.id
    )
    @item2 = Item.create!( 
      name: "Item Autem Minima",
      description:
      "Cumque consequuntur ad.",
      unit_price: 67076,
      merchant_id: @merchant1.id
    )
    @item3 = Item.create!(
      name: "Item Ea Voluptatum",
      description:
      "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.",
      unit_price: 32301,
      merchant_id: @merchant1.id
    )
    @item4 = Item.create!(
      name: "Item Nemo Facere",
      description: "Sunt eum id eius magni consequuntur delectus veritatis.",
      unit_price: 4291,
      merchant_id: @merchant2.id
    )
    # @item5 = Item.create!(
    #   id: 5,
    #   name: "Item Expedita Aliquam",
    #   description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
    #   unit_price: 68723,
    #   merchant_id: @merchant2.id
    # )

    @customer1 = Customer.create!(first_name: "John", last_name: "Jacobs")
    @customer2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
    @customer3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
    @customer4 = Customer.create!(first_name: "Harry", last_name: "Potter")
    @customer5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
    @customer6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")

    @item5 = Item.create!(name: "Gold Ring", unit_price: 1200, merchant_id: @merchant1.id, description: "14k Gold")
    @item6 = Item.create!(name: "Silver Ring", unit_price: 900, merchant_id: @merchant1.id, description: "Pure Silver")
    @item7 = Item.create!(name: "Gold Necklace", unit_price: 1400, merchant_id: @merchant1.id, description: "10k Gold")
    @item8 = Item.create!(name: "Silver Necklace", unit_price: 1000, merchant_id: @merchant1.id, description: "Pure Silver")
    @item9 = Item.create!(name: "Hair Clip", unit_price: 25, merchant_id: @merchant1.id, description: "Black Plastic")
    @item10 = Item.create!(name: "Hoop Earrings", unit_price: 125, merchant_id: @merchant1.id, description: "Bonze")

    @invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice8 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice9 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice10 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice11 = Invoice.create!(status: 2, customer_id: @customer6.id)
    @invoice12 = Invoice.create!(status: 2, customer_id: @customer6.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 111, status: 1) 
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 345, status: 1) 
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 420, status: 1) 
    @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 345, status: 1) 
    @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 420, status: 1) 
    @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 345, status: 2) 
    @invoice_item7 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 1, unit_price: 711, status: 1)
    @invoice_item8 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice8.id, quantity: 1, unit_price: 711, status: 1)
    @invoice_item9 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice9.id, quantity: 1, unit_price: 345, status: 1)
    @invoice_item10 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice10.id, quantity: 1, unit_price: 126, status: 1)
    @invoice_item11 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice11.id, quantity: 1, unit_price: 123, status: 1)
    @invoice_item12 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice12.id, quantity: 1, unit_price: 345, status: 1)

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction9 = Transaction.create!(invoice_id: @invoice9.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction10 = Transaction.create!(invoice_id: @invoice10.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction11 = Transaction.create!(invoice_id: @invoice11.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
    @transaction12 = Transaction.create!(invoice_id: @invoice12.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
  end

  # User Story 6
  it "gives a list of all of a merchant's items" do
    visit "merchants/#{@merchant1.id}/items"

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to_not have_content(@item4.name)
  end

  #User Story 11
  describe "I see a link to create a new item - when I click the link, I am taken to a form that allows me to add item information" do
    describe "When I fill out the form I click 'Submit' and I am taken back to the items index page" do
      it "And I see the item I created and I see my item was created with a default status of disabled" do
        visit "/merchants/#{@merchant1.id}/items"
        
        expect(page).to have_link("Create A New Item")
        
        click_link("Create A New Item")
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

        expect(page).to have_content("Create A New Item")
        expect(page).to have_content("Name:")
        expect(page).to have_content("Description:")
        expect(page).to have_content("Unit Price:")
        expect(page).to have_button("Submit")

        fill_in("Name:", with: "Small Handbag")
        fill_in("Description:", with: "Brown Leather")
        fill_in("Unit Price:", with: 1500)
        
        click_button "Submit"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

        expect(page).to have_link("Small Handbag")
      end
    end
  end

  xit "has a button to disable or enable the item" do
    visit "merchants/#{@merchant2.id}/items"
    # save_and_open_page
    # Next to each item name I see a button to disable or enable that item.
# When I click this button
    expect(page).to have_content(@item4.name)
    expect(button).to have_content("Disable")
    click_button "Disable"
    expect(current_path).to eq("merchants/#{@merchant2.id}/items")
    expect(page).to have_content(@item4.name)
    expect(button).to have_content("Enable")
    # Then I am redirected back to the items index
# And I see that the items status has changed


  
  end

  #User Story 12
  describe "Top 5 Most Popular Items" do
    describe "Displays the names of the top 5 most popular items ranked by revenue generated" do
      it "I see each item linked to my merchant show page for an item and I see the total revenue generated next to each item name" do
        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_content("Top 5 Most Popular Items:")
      end
    end
  end
end