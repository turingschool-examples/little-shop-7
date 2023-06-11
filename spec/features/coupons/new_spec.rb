require "rails_helper"

RSpec.describe "Create Coupons Form" do
  before(:each) do
    @merchant_1 = create(:merchant)

    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 0, value: 20, coupon_type: 1)
    @coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 1)
    @coupon_3 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 0, value: 10, coupon_type: 1)
    @coupon_4 = @merchant_1.coupons.create!(code: "5OFF", name: "Spring Sale", status: 0, value: 5, coupon_type: 1)
  end
  describe "As a Merchant" do
    describe "When I visit the new coupon form" do
      it "Has a form to create a new coupon" do
        visit new_merchant_coupon_path(@merchant_1)

        expect(page).to have_content("Create New Coupon")
        expect(page).to have_field("Code")
        expect(page).to have_field("Name")
        expect(page).to have_field("Value")
        page.has_selector?("Percent Off")
        page.has_selector?("Dollar Off")
        page.has_selector?("Active")
        page.has_selector?("Disabled")
        expect(page).to have_button("Create Coupon")
      end

      it "Can create a new coupon" do
        visit new_merchant_coupon_path(@merchant_1)

        fill_in "Code", with: "25OFF"
        fill_in "Name", with: "Black Friday"
        fill_in "Value", with: 25
        select "Percent Off", from: "coupon_type"
        click_button "Create Coupon"

        expect(current_path).to eq(merchant_coupons_path(@merchant_1))
        expect(page).to have_content("Black Friday")
        expect(page).to have_content("25 percent Off!")
      end

      it "Flashes an error if the form is not filled out completely" do
        visit new_merchant_coupon_path(@merchant_1)

        fill_in "Code", with: "25OFF"
        fill_in "Name", with: "Black Friday"
        # fill_in "Value", with: 25
        select "Percent Off", from: "coupon_type"
        click_button "Create Coupon"

        expect(current_path).to eq(new_merchant_coupon_path(@merchant_1))
        expect(page).to have_content("Please fill out all fields")
      end

      it "Flashes an error if the coupon code already exists" do
        visit new_merchant_coupon_path(@merchant_1)

        fill_in "Code", with: "20OFF"
        fill_in "Name", with: "Sunday Funday"
        fill_in "Value", with: 25
        select "Percent Off", from: "coupon_type"
        click_button "Create Coupon"

        expect(current_path).to eq(new_merchant_coupon_path(@merchant_1))
        expect(page).to have_content("Coupon code already exists")
      end
    end
  end

end