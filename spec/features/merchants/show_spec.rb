require "rails_helper"

RSpec.describe "merchant dashboard show page" do
  before :each do
    @merchant_1 = create(:merchant)
    # @item_1 = create(:item)
  end

  # US 1
  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end

  describe "Merchant Dashboard Links" do
    # US 2
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

  describe "merchant dashboard top customers" do
    it "shows a list of the top 5 customers and a count of their successful transactions" do
      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content("1. #{@customer_1.first_name} #{@customer_1.last_name} - 5 purchases")
      expect(page).to have_content("2. #{@customer_2.first_name} #{@customer_2.last_name} - 4 purchases")
      expect(page).to have_content("3. #{@customer_3.first_name} #{@customer_3.last_name} - 3 purchases")
      expect(page).to have_content("4. #{@customer_4.first_name} #{@customer_4.last_name} - 2 purchases")
      expect(page).to have_content("5. #{@customer_5.first_name} #{@customer_5.last_name} - 1 purchases")
      expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
      expect(page).to_not have_content(@customer_6.first_name)
    end
  end
end