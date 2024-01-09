require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do 
    @merchants = create_list(:merchant, 5)
    @merchants.first.items = create_list(:item, 5)
    # @merchant_2 = create(:merchant)
    # @merchants = create_list(:merchant, 10)
    # @merchants.each do |merch|
    #   Merchant.create!(name: merch.name)
    # end
    require 'pry'; binding.pry
    # @items_merch_1.createcreate_list(:item, 10)
   
  end

  it "shows the name of the merchant" do 
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_content(@merchant.name)
  end

  it "has links to the merchant items index and the merchant invoices index" do 
    visit "/merchants/#{@merchant.id}/dashboard"
    
    expect(page).to have_link("Invoices")
    expect(page).to have_link("Items")

    click_link "Items" 
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    visit "/merchants/#{@merchant.id}/dashboard"

    click_link "Invoices" 
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end

  it "has a list of the top five customers who have conducted the largest number of transactions with a merchant" do 
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have
  end
  
end 