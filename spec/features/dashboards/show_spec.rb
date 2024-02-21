require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
  let!(:merchant_1) { Merchant.create!(name: "John Doe")}
  describe "As a merchant" do
    it "shows the name of my merchant" do
      visit merchant_dashboard_path(merchant_id: merchant_1.id)

      expect(page).to have_content(merchant_1.name)
    end
  end
end
