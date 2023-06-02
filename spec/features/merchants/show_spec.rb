require "rails_helper"

RSpec.describe "/merchants/:id/dashboard" do
  describe "As a visitor" do
    describe "when I visit a merchants show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      # User Story 1

      it "directs me to the merchants dashboard where I see the merchants name" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit "/merchants/#{merchant_2.id}/dashboard"
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end

    end
  end
end