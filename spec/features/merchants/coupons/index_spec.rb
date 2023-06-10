require "rails_helper"

RSpec.describe "Coupons Index Page" do
  before(:each) do
    @merchant_1 = create(:merchant)

    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 0, value: 20, coupon_type: 1)
    @coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 1)
  end

  describe "As a Merchant" do
    it "shows all coupons names and amount off" do
      visit merchant_coupons_path(@merchant_1)

      expect(page).to have_link("#{@coupon_1.name}")
      expect(page).to have_content("#{@coupon_1.value} Off!")

      expect(page).to have_link("#{@coupon_2.name}")
      expect(page).to have_content("#{@coupon_2.value} Off!")
    end
  end
end