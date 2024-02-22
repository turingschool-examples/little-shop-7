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

  describe 'US 2' do
    it ' link to my merchant items index' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link('My Items')

      click_link("My Items")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it 'link to my merchant invoices index ' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link('My Invoices')

      click_link("My Invoices")

      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    
    end
  end
end