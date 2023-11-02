require "rails_helper"
#user story 1
RSpec.describe "merchant dashboard index page" do
  before :each do
    @merchant_1 = create(:merchant)
  end

  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end
  #user story 2
  describe "Merchant Dashboard Links" do
    it "shows links to merchant items index and merchant invoices index" do
      visit merchant_dashboard_path(@merchant_1)
      
      expect(page).to have_content("Items")
      expect(page).to have_content("Invoices")

      click_link("Items")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      
      visit merchant_dashboard_path(@merchant_1)

      click_link("Invoices")

      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    end
  end
end