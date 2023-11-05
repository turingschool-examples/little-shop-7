require "rails_helper"

RSpec.describe "the merchants index" do

  it "lists all merchants in the system" do
    merchant1 = Merchant.create!(name: "Sooyung LLC")
    merchant2 = Merchant.create!(name: "Joseph LLC")
    merchant3 = Merchant.create!(name: "Anthea LLC")
    merchant4 = Merchant.create!(name: "Nathan LLC")

    visit "/admin/merchants"

    expect(page).to have_content(merchant1.name)
    expect(page).to have_content(merchant2.name)
    expect(page).to have_content(merchant3.name)
    expect(page).to have_content(merchant4.name)
  end

  it "has buttons to enable or disable each merchant and disables when 'Disable' is clicked" do
    merchant1 = Merchant.create!(name: "Sooyung LLC")

    visit "/admin/merchants"

    expect(page).to have_link(merchant1.name)
    expect(merchant1.enabled).to be(true)
    expect(page).to have_button("Disable")
    click_button("Disable")
    expect(page).to have_current_path("/admin/merchants")

    merchant1.reload
    expect(merchant1.enabled).to be(false)
  end

  it "has buttons to enable or disable each merchant and enables when 'Enable' is clicked" do
    merchant1 = Merchant.create!(name: "Sooyung LLC", enabled: false)

    visit "/admin/merchants"

    expect(page).to have_link(merchant1.name)
    expect(merchant1.enabled).to be(false)
    expect(page).to have_button("Enable")
    click_button("Enable")
    expect(page).to have_current_path("/admin/merchants")

    merchant1.reload
    expect(merchant1.enabled).to be(true)
  end

  it "checks to see if there are the sections of 'Enabled Merchants' and 'Disabled Merchants'" do
    visit "/admin/merchants"

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")
  end
end

