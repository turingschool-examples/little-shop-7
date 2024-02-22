require 'rails_helper'

RSpec.describe 'merchants#index', type: :feature do
  describe 'As a merchant' do
    before(:each) do
      @merchants = create_list(:merchant, 10)
      @merch_1 = @merchants[0] 
    end

    # us#1 Merchant Dashboard
    it 'displays merchant name' do
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      visit merchant_dashboard_index_path(@merch_1.id)
      # Then I see the name of my merchant
      expect(page).to have_content(@merch_1.name)
    end
    
    # 2. Merchant Dashboard Links
    it 'has clickable links' do
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      visit merchant_dashboard_index_path(@merch_1.id)
      # Then I see link to my merchant items index (/merchants/:merchant_id/items)
      expect(page).to have_link("Merchant Items")
      # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
      expect(page).to have_link("Merchant Invoice Items")
    end
  end
end