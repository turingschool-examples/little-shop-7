require 'rails_helper' 

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    
    @item_1 = Item.create!(name: "item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: 75107, status: nil, merchant_id: @merchant_1.id)

    @item_2 = Item.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.", unit_price: 67076, status: nil, merchant_id: @merchant_1.id)

    
  end

  describe "as a merchant" do
    describe "when I visit my merchant dashboard" do
      it "displays the name of my merchant" do
        visit merchant_dashboards_path(@merchant_1)

        expect(page).to have_content(@merchant_1.name)
      end

      #User Story 2
      it "I see a link to my merchant items index (/merchants/:merchant_id/items)" do
        visit merchant_dashboards_path(@merchant_1)
       
        expect(page).to have_link("My Items", href: merchant_items_path(@merchant_1))
      end

      it "And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)" do
        visit merchant_dashboards_path(@merchant_1)
     
        expect(page).to have_link("My Invoices", href: merchant_invoices_path(@merchant_1))
      end
    end
  end
end