require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/merchants'" do
  before :each do
    @gap = Merchant.create!(name: "Gap")
    @handm = Merchant.create!(name: "H & M")
    @nike = Merchant.create!(name: "Nike")
  end
  #user story 24
  it "I see the name of each merchant in the system" do
    visit 'admin/merchants'

    within("#merchant-#{@gap.id}") do
      expect(page).to have_content(@gap.name)
    end

    within("#merchant-#{@handm.id}") do
      expect(page).to have_content(@handm.name)
    end

    within("#merchant-#{@nike.id}") do
      expect(page).to have_content(@nike.name)
    end
  end

  #user story 25
  it "each name is a link to the merchant's show page" do
    visit 'admin/merchants'

    within("#merchant-#{@gap.id}") do
      click_button "#{@gap.name}"

      expect(current_path).to eq("admin/merchants/#{@gap.id}")
    end

    within("#merchant-#{@handm.id}") do
      click_button "#{@handm.name}"
    end

    within("#merchant-#{@nike.id}") do
      click_button "#{@nike.name}"
    end
  end
end