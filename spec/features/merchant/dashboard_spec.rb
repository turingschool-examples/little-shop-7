require 'spec_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do 
    @merchant_1 = Merchant.create!(name: "Betty Borg")
  end

  #User Story 1
  describe '/merchants/:merchant_id/dashboard' do 
    it 'merchant dashboard shows the name of the merchant' do
      visit "/merchants/#{@merchant_1.id}/dashboard" 
      expect(page).to have_content("Welcome back, Betty Borg")
    end
  end
end