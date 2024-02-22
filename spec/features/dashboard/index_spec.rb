require "rails_helper"

RSpec.describe "Dashboard index" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "bob")
  end

  describe 'US1' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end
end