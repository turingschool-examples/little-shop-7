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

    it "displays a button next to each merchant to enable or disable the merchant" do
      visit "/admin/merchants"

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")
        
        expect(page).to have_button("Disable #{merchant_1.name}")
        expect(page).to have_button("Disable #{merchant_2.name}")
        expect(page).to have_button("Disable #{merchant_3.name}")

        click_button("Disable #{merchant_1.name}")
      end

      expect(current_path).to eq("/admin/merchants")

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")
        
        expect(page).to have_button("Disable #{merchant_2.name}")
        expect(page).to have_button("Disable #{merchant_3.name}")
      end

      within ".disabled_admin_merchants" do
        expect(page).to have_link("#{merchant_1.name}")
        
        expect(page).to have_button("Enable #{merchant_1.name}")
      end

      expect(merchant_1.status).to eq("disabled")
      expect(merchant_2.status).to eq("enabled")
      expect(merchant_3.status).to eq("enabled")
    end
  end
end