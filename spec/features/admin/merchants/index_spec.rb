require "rails_helper"

RSpec.describe "/admin/merchants" do
  describe "as an admin" do
    let!(:merchant_1) { create(:merchant, status: 0) }
    let!(:merchant_2) { create(:merchant, status: 0) }
    let!(:merchant_3) { create(:merchant, status: 0) }
    let!(:merchant_4) { create(:merchant, status: 1) }

    it "displays the name of each merchant in the system" do
      visit "/admin/merchants"

      within ".enabled_admin_merchants" do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end

    it "displays a link to each of the merchants on the admin merchants index page" do
      visit "/admin/merchants"

      within ".enabled_admin_merchants" do
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
        expect(page).to have_content("Enabled Merchants")
        expect(page).to_not have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")
        
        expect(page).to_not have_button("Disable #{merchant_1.name}")
        expect(page).to have_button("Disable #{merchant_2.name}")
        expect(page).to have_button("Disable #{merchant_3.name}")
      end

      within ".disabled_admin_merchants" do
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to_not have_link("#{merchant_2.name}")
        expect(page).to_not have_link("#{merchant_3.name}")

        expect(page).to have_button("Enable #{merchant_1.name}")
        expect(page).to_not have_button("Disable #{merchant_2.name}")
        expect(page).to_not have_button("Disable #{merchant_3.name}")
      end
    end

    it "can update from enabled to disabled" do
      visit "/admin/merchants"

      within ".disabled_admin_merchants" do
        expect(page).to have_link("#{merchant_4.name}")
        
        expect(page).to have_button("Enable #{merchant_4.name}")

        click_button("Enable #{merchant_4.name}")
      end

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_4.name}")
        
        expect(page).to have_button("Disable #{merchant_4.name}")

        click_button("Disable #{merchant_4.name}")
      end
    end

    it "displays a link to create a new merchant" do
      visit "/admin/merchants"

      expect(page).to have_link("Create New Merchant")
    end

    it "the link takes me to a new page to create a merchant" do
      visit "/admin/merchants"

      click_link("Create New Merchant")

      expect(current_path).to eq("/admin/merchants/new")
    end
  end
end