require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do 
    @merchant = Merchant.create!(id: 1, name: "Home Depot")
  end

  it "shows the name of the merchant" do 
    require 'pry'; binding.pry
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_content(@merchants.first.name)
  end
  
end 