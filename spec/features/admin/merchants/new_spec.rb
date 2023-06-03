require "rails_helper"

RSpec.describe "/admin/merchants/new" do
  describe "As an Admin" do
    let!(:merchant_1) { create(:merchant, status: 0) }

    it "displays a form to create a new merchant" do
      visit "/admin/merchants/new"

      expect(page).to have_field("Name:")
      fill_in("Name:", with: "Busta Rhymes")
      click_button("Submit")

      expect(current_path).to eq("/admin/merchants")

      within ".enabled_admin_merchants" do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to_not have_content("Busta Rhymes")
      end

      within ".disabled_admin_merchants" do
        expect(page).to_not have_content("#{merchant_1.name}")
        expect(page).to have_content("Busta Rhymes")
      end
    end

    it "can display error messages if fields are not filled out" do
      visit "/admin/merchants/new"

      click_button("Submit")

      expect(current_path).to eq("/admin/merchants/new")
      expect(page).to have_content("Name can't be blank")
    end
  end
end