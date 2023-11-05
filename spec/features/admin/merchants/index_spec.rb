require "rails_helper"

RSpec.describe "the merchants index" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Sooyung LLC")
    @merchant2 = Merchant.create!(name: "Joseph LLC")
    @merchant3 = Merchant.create!(name: "Anthea LLC")
    @merchant4 = Merchant.create!(name: "Nathan LLC")
  end

  it "lists all merchants in the system" do

    visit "/admin/merchants"

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
  end

  it "has buttons to enable or disable each merchant" do
    visit "/admin/merchants"

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")
    expect(page).to have_content(@merchant1.name)

    within("#enabled_merchant-#{@merchant1.id}") do
      expect(@merchant1.enabled).to be(true)
      expect(page).to have_button("Disable")
      click_button("Disable")
    end
    expect(page).to have_current_path("/admin/merchants/#{@merchant1.id}")
    expect(@merchant1.enabled).to be(false)
  end
end

