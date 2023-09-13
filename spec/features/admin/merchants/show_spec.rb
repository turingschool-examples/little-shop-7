require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/merchants/:id'" do
  before :each do
    @gap = Merchant.create!(name: Faker::Name.name)
    @handm = Merchant.create!(name: "H & M")
    @nike = Merchant.create!(name: "Nike")
  end

  #user story 26
  it "I see alink to update the merchant's info" do
    visit "/admin/merchants/#{@gap.id}"

    click_button "Update Merchant Name"

    expect(current_path).to eq("/admin/merchants/#{@gap.id}/edit")

    click_button "Submit"

    expect(current_path).to eq("/admin/merchants/#{@gap.id}/edit")
    expect(page).to have_content("Error: Name can't be blank")

    fill_in :name, with: "Baby Gap"

    click_button "Submit"

    expect(current_path).to eq("/admin/merchants/#{@gap.id}")
    expect(@gap.name).to eq("Baby Gap")
    expect(page).to have_content(@gap.name)
    expect(page).to have_content("Merchant name has been updated")
  end

end