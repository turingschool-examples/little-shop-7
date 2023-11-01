require "rails_helper"

RSpec.describe "merchant dashboard index page" do
  before :each do
    @merchant_1 = create(:merchant)
    # @item_1 = create(:item)
  end

  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end
  describe "Merchant Dashboard Links" do
    it "shows links to merchant items index and merchant invoices index" do
      visit merchant_dashboard_path(@merchant_1)
      
      expect(page).to have_content("Items")
      expect(page).to have_content("Invoices")

      click_link("Items")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      
      visit merchant_dashboard_path(@merchant_1)

      click_link("Invoices")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end
  end
end