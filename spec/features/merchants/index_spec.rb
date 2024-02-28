require 'rails_helper'

RSpec.describe 'Merchant Index', type: :feature do
 describe 'As a merchant' do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Amazon", status: 0) 
    @merchant_2 = create(:merchant, name: "Walmart", status: 0) 
    @merchant_3 = create(:merchant, name: "Apple", status: 0) 
    @merchant_4 = create(:merchant, name: "Microsoft", status: 0) 
    @merchant_5 = create(:merchant, name: "Petco", status: 1) 
    @merchant_6 = create(:merchant, name: "Aetna", status: 1) 
    @merchant_7 = create(:merchant, name: "Adidas", status: 1)
  end

  it 'displays a list of the merchant names as links to their merchant dashboard' do
    visit merchants_path

    expect(page).to have_link("Amazon")
    expect(page).to have_link("Walmart")
    expect(page).to have_link("Apple")
    expect(page).to have_link("Microsoft")
    expect(page).to have_link("Petco")
    expect(page).to have_link("Aetna")
    expect(page).to have_link("Adidas")
  end
 end
end