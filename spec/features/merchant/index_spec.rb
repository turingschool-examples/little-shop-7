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
  end
end