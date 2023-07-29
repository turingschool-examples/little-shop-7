require 'rails_helper'

RSpec.describe '/admin /merchants', type: :feature do
  describe 'admin merchants index page' do
    it "has the name of each merchant in the system" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')
      merchant_2 = Merchant.create!(name: 'Merchant_2')
      merchant_3 = Merchant.create!(name: 'Merchant_3')

      visit '/admin/merchants'
      
      expect(page).to have_content('Merchant_1')
      expect(page).to have_content('Merchant_2')
      expect(page).to have_content('Merchant_3')
    end

    it "has buttons to disable or enable each merchant" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')
      merchant_2 = Merchant.create!(name: 'Merchant_2')
      merchant_3 = Merchant.create!(name: 'Merchant_3')

      visit '/admin/merchants'
      within("tr#em-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
  
      within("tr#em-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
  
      within("tr#em-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
    end
  end
end