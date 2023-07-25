require "rails_helper"

RSpec.describe "Merchant Show Page" do
  describe "Dashboard" do
  #User Story 1
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant
    it "Displays the name of the merchant" do
      @merchant_1 = Merchant.create(name: "Steve")
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content(@merchant_1.name)
    end

  #User Story 2 As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see link to my merchant items index (/merchants/:merchant_id/items)
  # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    it "I see a link to my merchant items index" do
      @merchant_1 = Merchant.create(name: "Steve")
      @item_1 = Item.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: 75107, merchant_id: @merchant_1.id  )
      @item_2 = Item.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.", unit_price: 67076, merchant_id: @merchant_1.id )

      visit "/merchants/#{@merchant_1.id}/dashboard"
    end
  end
end