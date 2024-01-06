require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do 
    @merchant = create(:merchant)
  end

  it "shows the name of the merchant" do 
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_content(@merchant.name)
  end

  it "has links to the merchant items index and the merchant invoices index" do 
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_link("Merchant items")
    expect(page).to have_link("Merchant invoices")

    click_link "Merchant items" 
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    visit "/merchants/#{@merchant.id}/dashboard"

    click_link "Merchant invoices" 
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end
  
end 