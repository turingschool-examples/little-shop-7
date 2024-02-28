require 'rails_helper'

RSpec.describe 'Admin Merchants New Page', type: :feature do
  describe 'As an admin' do
    
    # User story 29. Admin Merchant Create continued
    it 'shows a form to create a new merchant with a default status, and returns to the admin merchants index page where it is displayed with the entered info and default status' do
      visit new_admin_merchant_path

      expect(page).to have_field("name")
      # When I fill out the form I click ‘Submit’
      fill_in "name", with: "Nike"
      click_on "Submit"
      # Then I am taken back to the admin merchants index page
      expect(current_path).to eq(admin_merchants_path)
      # And I see the merchant I just created displayed
      # And I see my merchant was created with a default status of disabled.
      within "#disabled_merchants" do
        expect(page).to have_content("Nike")
      end
    end

    #Sad path testing for user story #29
    it "responds to incomplete information in the form" do
      visit new_admin_merchant_path
      fill_in(:name, with: "")
      click_button("Submit")

      expect(current_path).to eq(new_admin_merchant_path)

      within "#flash" do
        expect(page).to have_content("Error: Name can't be blank")
      end
    end
  end
end