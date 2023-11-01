require "rails_helper"

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hannah's Handbags")
    @merchant2 = Merchant.create!(name: "Jason's Burgers")
    @item1 = Item.create!(
      id: 1,
      name: "Item Qui Esse",
      description:
      "Nihil autem sit odio inventore deleniti.",
      unit_price: 75107,
      merchant_id: @merchant1.id
    )
    @customer1 = Customer.create!(id: 1, first_name: "Alan", last_name: "Smith")
    @invoice1 = Invoice.create!(id: 1, status: 1, customer_id: @customer1.id)
    @invoice_item = InvoiceItem.create!(
      item_id: @item1.id,
      invoice_id: @invoice1.id,
      quantity: 1,
      unit_price: @item1.unit_price
    )
    @item2 = Item.create!( 
      id: 2,
      name: "Item Autem Minima",
      description:
      "Cumque consequuntur ad.",
      unit_price: 67076,
      merchant_id: @merchant1.id
    )
  end

  describe "As a merchant" do
    #User Story 1
    describe "When I visit my merchant dashboard" do
      it "I see the name of my merchant" do

        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content(@merchant1.name)
        # expect(page).to_not have_content(@merchant2.name)
      end
      
      it "I see a link to my merchant items index" do 
        
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        expect(page).to have_link("Items")
        click_link("Items")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      end

      it "I see a link to my merchant invoices index" do 
        visit "/merchants/#{@merchant2.id}/dashboard"
        
        expect(page).to have_link("Invoices")
        click_link("Invoices")
        
        expect(current_path).to eq("/merchants/#{@merchant2.id}/invoices")
      end

      it "has a section for items ready to ship, with a list of items that need to be shipped" do
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content("Items Ready To Ship")
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)

      end

      it "has an invoice id next to each item, and the id links to the merchant invoice show page" do 

        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_link("Invoice ID")
        click_link("Invoice ID")
        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")

      end
    end
  end
end