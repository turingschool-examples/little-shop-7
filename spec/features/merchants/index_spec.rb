require "rails_helper"

RSpec.describe "merchant dashboard index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "index page" do
    it "lists all merchant's names" do
      visit merchants_path

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
    end

    it "merchant's names link to their dashboard page" do
      visit merchants_path

      click_link "#{@merchant_1.name}"

      expect(current_path).to eq(merchant_dashboard_path(@merchant_1))
    end
  end
end