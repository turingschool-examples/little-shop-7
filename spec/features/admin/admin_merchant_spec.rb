require "rails_helper"

RSpec.describe "Admin Merchant Page", type: :feature do
  describe "When I visit the merchant index (/admin/merchants)" do
    # US 24
    it "I a list of all the merchants" do
      merchant_1 = Merchant.create!(name: "Bob's Burgers")
      visit admin_merchants_path

      expect(page).to have_content("Bob's Burgers")
    end
  end

  describe "When I visit the merchant index (/admin/merchants)" do
  # US 25
  it "I can click on a merchant name and be taken to the merchant show page" do
    merchant_1 = Merchant.create!(name: "Bob's Burgers")
    merchant_2 = Merchant.create!(name: "Kwik-E-Mart")
    visit admin_merchants_path
    expect(page).to have_link("Bob's Burgers")
  

    click_link("Bob's Burgers")
    expect(current_path).to eq(admin_merchant_path(merchant_1))
    end
  end

#   26. Admin Merchant Update

# As an admin,
# When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
  
  describe "When I visit the merchant show page (/admin/merchants/:merchant_id)" do
    it "I see a link to update the merchant's information" do
      merchant_1 = Merchant.create!(name: "Bob's Burgers")

      visit admin_merchant_path(merchant_1)
      expect(page).to have_link('Update Merchant Information', href: admin_merchant_path(merchant_1))

      click_link 'Update Merchant Information'
      expect(page).to have_current_path(admin_merchant_path(merchant_1))
      expect(find_field(:name).value).to eq(merchant.name)
  
      fill_in 'name', with: "Robert's Hamburgers"
      click_button 'Update Merchant Information'

      expect(page).to have_current_path(admin_merchant_path(merchant_1))
      expect(page).to have_content("Robert's Hamburgers")
      expect(page).to have_content('Merchant information updated successfully.')
    end
  end
end
