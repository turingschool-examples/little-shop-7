require "rails_helper"

RSpec.describe "/admin/merchants/:id" do
  describe "As an Admin" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }
    let!(:merchant_3) { create(:merchant) }

    it "displays the specific admin/merchants show page" do
      visit "/admin/merchants/#{merchant_2.id}"

      expect(page).to have_content("#{merchant_2.name}")

      expect(page).to_not have_content("#{merchant_1.name}")
      expect(page).to_not have_content("#{merchant_3.name}")
    end
  end
end