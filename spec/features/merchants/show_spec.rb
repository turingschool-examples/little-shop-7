require "rails_helper"

RSpec.describe "Merchant Dashboard Index Page" do 
  before(:each) do 
    @merchant = create(:merchant)
  end

  describe "Merchant Dashboard Display" do 
    #User Story 1
    it "displays the name of the merchant" do 
      visit merchant_dashboard_path(@merchant) 

      expect(page).to have_content(@merchant.name)
    end

    #user story 2
    it "displays links to merchant items index and merchant invoices index" do 
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_link("Items Index")
      expect(page).to have_link("Invoices Index")
    end
  end
end