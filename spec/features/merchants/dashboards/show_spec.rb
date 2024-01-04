require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do 
    @merchant = create(:merchant)
    # @merchant = Merchant.create!(name: "Home Depot")
  end

  it "shows the name of the merchant" do 
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_content(@merchant.name)
  end
  
end 