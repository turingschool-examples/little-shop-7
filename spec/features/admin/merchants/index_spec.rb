require "rails_helper"

RSpec.describe "Admin Merchants" do 
  
  # US 24- Merchant Index 
  it "shows the names of each merchant in the system" do 
    load_test_data

    visit '/admin/merchants'

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
    expect(page).to have_content(@merchant5.name)
    expect(page).to have_content(@merchant6.name)
    expect(page).to have_content(@merchant7.name)
    expect(page).to have_content(@merchant8.name)
    expect(page).to have_content(@merchant9.name)
    expect(page).to have_content(@merchant10.name)
  end

  it "has a enable button on disabled merchants" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    visit '/admin/merchants'
    
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

  it "has a enable button that changes the merchant status and returns you back to the merchant index" do
    merchant1= Merchant.create!(name: "No Face", status: "disabled")
    merchant2 = Merchant.create!(name: "Totoro", status: "enabled")
    merchant3 = Merchant.create!(name: "Kiki", status: "enabled")

    visit '/admin/merchants'
    
    expect("Enabled Merchants").to appear_before("Totoro")
    expect("Totoro").to appear_before("Disabled Merchants")
    expect("Disabled Merchants").to appear_before("No Face")
  end




end