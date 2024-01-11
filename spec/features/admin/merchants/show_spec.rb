require "rails_helper"

RSpec.describe "Admin Merchants Show Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "John")
  end

  describe "User Story 26" do
    it "allows the admin to edit merchant information" do
      visit admin_merchant_path(@merchant_1)
  
      click_link "Edit Merchant"
  
      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))

      fill_in "Name", with: "Larry"

      click_on "Save Changes"

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Larry")
    end
  end
end