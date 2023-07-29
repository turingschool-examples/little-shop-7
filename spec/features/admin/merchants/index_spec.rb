require 'rails_helper'

RSpec.describe 'admin merchants index page' do

  it "has the name of each merchant in the system" do
    merchant_1 = Merchant.create!(name: 'Merchant_1')
    merchant_2 = Merchant.create!(name: 'Merchant_2')
    merchant_3 = Merchant.create!(name: 'Merchant_3')

    visit '/admin/merchants'
    
    expect(page).to have_content('Merchant_1')
    expect(page).to have_content('Merchant_2')
    expect(page).to have_content('Merchant_3')
  end
end