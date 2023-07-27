require "rails_helper"

RSpec.describe "Merchant Show Page" do
  describe "Dashboard" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @item_1 = create(:item)
      @item_2 = create(:item)
    end
    #User Story 1
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant
    it "Displays the name of the merchant" do
      
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content(@merchant_1.name)
    end

  #User Story 2 As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see link to my merchant items index (/merchants/:merchant_id/items)
  # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    describe "User Story 2" do
      it "I see a link to my merchant items index" do
        
        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_button("#{@merchant_1.name} Items")
        expect(page).to have_button("#{@merchant_1.name} Invoices")
      end
    end


    #User Story 3 
      #Merchant Dashboard Statistics - Favorite Customers

      # As a merchant,
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # Then I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant
      # And next to each customer name I see the number of successful transactions they have conducted with my merchant

      describe "User Story 3" do
        it "I see a link to my merchant items index" do

          visit "/merchants/#{@merchant_1.id}/dashboard"
        end
      end
  end
end