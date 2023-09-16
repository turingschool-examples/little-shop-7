require "rails_helper"

RSpec.describe "Merchant Item Index page" do 
  before(:each) do 
    load_test_data
  end
  it "shows a list of all my items" do 
    visit "merchants/#{@merchant1.id}/items"

    within "#merchant_name" do 
      expect(page).to have_content(@merchant1.name)
    end

    within "#merchant_items" do 
      expect(page).to have_content("Colgate")
      expect(page).to have_content("Red Bell Pepper")
      expect(page).to have_content("Huskies")
      expect(page).to have_content("Gatorade")
      expect(page).to have_content("Pretzels")
      expect(page).to have_content("Chicken Breast")
      expect(page).to have_content("Coors")
      expect(page).to have_content("Mug")
    end
  end

  it "doesn't show the items of any other merchant" do 
    visit "merchants/#{@merchant1.id}/items"

    within "#merchant_items" do 
      expect(page).to_not have_content("Book")
      expect(page).to_not have_content("Card")
      expect(page).to_not have_content("Bag")
      expect(page).to_not have_content("Keychain")
      expect(page).to_not have_content("Lamp")
      expect(page).to_not have_content("Mouse")
      expect(page).to_not have_content("Clip")
      expect(page).to_not have_content("Shelf")
      expect(page).to_not have_content("Hook")
    end
  end

  it "has a link to each item's show page" do 
    visit "merchants/#{@merchant1.id}/items"

    within "#merchant_items" do 
      expect(page).to have_link 'Colgate'
      expect(page).to have_link 'Red Bell Pepper'
      expect(page).to have_link 'Huskies'
      expect(page).to have_link 'Gatorade'
      expect(page).to have_link 'Pretzels'
      expect(page).to have_link 'Chicken Breast'
      expect(page).to have_link 'Coors'
      expect(page).to have_link 'Mug'
    end
  end

  it "takes you to the merchant's item's show page when you click the item's link" do 
    visit "merchants/#{@merchant1.id}/items"

    within "#merchant_items" do 
      click_link 'Colgate'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item1.id}")
    end
  
    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Red Bell Pepper'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item2.id}")
    end

    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Huskies'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item3.id}")
    end
    
    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Gatorade'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item4.id}")
    end
    
    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Pretzels'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item5.id}")
    end

    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Chicken Breast'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item6.id}")
    end

    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Coors'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item7.id}")
    end

    visit "merchants/#{@merchant1.id}/items"
    within "#merchant_items" do 
      click_link 'Mug'
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item36.id}")

    end
  end

  it "has a enable button on disabled items" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    item1 = Item.create!(name: "chair", description: "you sit on it", unit_price: 2000, merchant: merchant1)
    item2 = Item.create!(name: "table", description: "you eat off it", unit_price: 3000, merchant: merchant2)
    item3 = Item.create!(name: "flower pot", description: "you plant in it", unit_price: 1000, merchant: merchant3)
    item4 = Item.create!(name: "gate", description: "you go through it", unit_price: 6000, merchant: merchant4)
    item5 = Item.create!(name: "grill", description: "you grill on it", unit_price: 90000, merchant: merchant5)
    item6 = Item.create!(name: "plant", description: "you water it", unit_price: 1000, merchant: merchant6)
    item6 = Item.create!(name: "stool", description: "you sit higher on it", unit_price: 7000, merchant: merchant7)

    visit "/merchants/#{merchant1}/items"

    within "#"

    expect(find("#merchant-#{merchant1.id}")).to have_button("Enable #{merchant1.name}")
  end

  it "has a disable button on enabled merchants" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    visit '/admin/merchants'
    
    expect(find("#merchant-#{merchant3.id}")).to have_button("Disable #{merchant3.name}")
  end

  it "has a disable button that changes the merchant status and returns you back to the merchant index" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    visit '/admin/merchants'
    
    expect(find("#merchant-#{merchant3.id}")).to have_button("Disable #{merchant3.name}")
    
    click_button "Disable #{merchant3.name}"
    
    expect(find("#merchant-#{merchant3.id}")).to have_button("Enable #{merchant3.name}")
  end

  it "has a enable button that changes the merchant status and returns you back to the merchant index" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    visit '/admin/merchants'
    
    expect(find("#merchant-#{merchant1.id}")).to have_button("Enable #{merchant1.name}")
    
    click_button "Enable #{merchant1.name}"
    
    expect(find("#merchant-#{merchant1.id}")).to have_button("Disable #{merchant1.name}")
  end
end