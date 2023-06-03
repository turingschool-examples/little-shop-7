require "rails_helper"

RSpec.describe "/admin/merchants" do
  describe "as an admin" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }
    let!(:merchant_3) { create(:merchant) }

    it "displays the name of each merchant in the system" do
      visit "/admin/merchants"

      within ".admin_merchants" do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end

    it "displays a link to each of the merchants on the admin merchants index page" do
      visit "/admin/merchants"

      within ".admin_merchants" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")

        click_link("#{merchant_2.name}")
      end

      expect(current_path).to eq("/admin/merchants/#{merchant_2.id}")
    end
  end
end