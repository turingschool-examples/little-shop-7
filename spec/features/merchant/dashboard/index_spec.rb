require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do
    load_data
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
    within ".top-five-cust" do 
      expect("#{@customers[4].last_name}, #{@customers[4].first_name}").to appear_before("#{@customers[7].last_name}, #{@customers[7].first_name}")
      expect("#{@customers[7].last_name}, #{@customers[7].first_name}").to appear_before("#{@customers[1].last_name}, #{@customers[1].first_name}")
      expect("#{@customers[1].last_name}, #{@customers[1].first_name}").to appear_before("#{@customers[3].last_name}, #{@customers[3].first_name}")
      expect("#{@customers[3].last_name}, #{@customers[3].first_name}").to appear_before("#{@customers[5].last_name}, #{@customers[5].first_name}")
    end
  end

end 