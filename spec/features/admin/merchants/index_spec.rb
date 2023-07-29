require "rails_helper"

RSpec.describe "/admin /merchants", type: :feature do
  describe "admin merchants index page" do
    it "has the name of each merchant in the system" do
      merchant_1 = Merchant.create!(name: "Merchant 1")
      merchant_2 = Merchant.create!(name: "Merchant 2")
      merchant_3 = Merchant.create!(name: "Merchant 3")

      visit "/admin/merchants"
      
      expect(page).to have_content("Merchant 1")
      expect(page).to have_content("Merchant 2")
      expect(page).to have_content("Merchant 3")
    end

    it "has buttons to disable or enable each merchant" do
      merchant_1 = Merchant.create!(name: "Merchant 1")
      merchant_2 = Merchant.create!(name: "Merchant 2")
      merchant_3 = Merchant.create!(name: "Merchant 3")

      visit "/admin/merchants"

      within("tr#em-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
  
      within("tr#em-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
  
      within("tr#em-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end
    end

    it "when clicked redirects to index and the status has changed" do
      merchant_1 = Merchant.create!(name: "Merchant 1")

      visit "/admin/merchants"
      
      click_button("Disable")
      
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Enable")
    end

    it "has merchants listed in appropriate sections for enabled or disabled" do
      merchant_1 = Merchant.create!(name: "Merchant 1")
      merchant_2 = Merchant.create!(name: "Merchant 2")
      merchant_3 = Merchant.create!(name: "Merchant 3", status: "disabled")
      merchant_4 = Merchant.create!(name: "Merchant 4", status: "disabled")

      visit "/admin/merchants"

      within("tr#em-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_3.name)
        expect(page).to_not have_content(merchant_4.name)
      end

      within("tr#em-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_3.name)
        expect(page).to_not have_content(merchant_4.name)
      end

      within("tr#dm-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to_not have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
      end

      within("tr#dm-#{merchant_4.id}") do
        expect(page).to have_content(merchant_4.name)
        expect(page).to_not have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
      end
    end

    it "creates new merchants" do
      visit "/admin/merchants"

      click_link("Create New Merchant")
      fill_in 'Name', with: "Bob's Ross"

      click_button("Submit")

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("Bob's Ross")
      expect(page).to have_button("Enable")
    end
  end
end