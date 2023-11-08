require 'rails_helper'

RSpec.describe "Admin Merchants Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant, enabled: true)
    @merchant2 = create(:merchant, enabled: true)
    @merchant3 = create(:merchant, enabled: true)
    @merchant4 = create(:merchant)
  end

  # US 24
  it "displays the name of each merchant" do
    visit admin_merchants_path

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  # US 25
  it "clicking the name redirects to merchant admin show page and displays the name" do
    visit admin_merchants_path

    expect(page).to have_link("#{@merchant1.name}, merchant ##{@merchant1.id}")
    click_link("#{@merchant1.name}, merchant ##{@merchant1.id}")
    expect(current_path).to eq(admin_merchant_path(@merchant1.id))
    expect(page).to have_content(@merchant1.name)
  end

  #US 27/28
  it "displays a button to disable or enable a merchant" do 
    visit admin_merchants_path
    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_content("status: enabled")
      expect(page).to have_button("Disable Merchant")
      click_on("Disable Merchant")
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button("Enable Merchant")
      click_on("Enable Merchant")
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button("Disable Merchant")
    end
    
    visit admin_merchants_path
    within("#enabled-merchants") do
    expect(page).to have_content("status: enabled")
    expect(page).to_not have_button("Enable Merchant")
    expect(page).to_not have_content("status: disabled")
    end

    visit admin_merchants_path
    within("#disabled-merchants") do
      expect(page).to have_content("status: disabled")
      expect(page).to_not have_button("Disable Merchant")
      expect(page).to_not have_content("status: enabled")
    end
  end
end
