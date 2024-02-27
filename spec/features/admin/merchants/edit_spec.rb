require 'rails_helper'

RSpec.describe 'Admin Merchants Edit View', type: :feature do
 describe 'As an Admin' do
  before(:each) do    
    @merchant_1 = create(:merchant, name: "Amazon") 
  end

  #User Story 26 (continued)
  it 'renders a form with the existing info and hasa button to return to the show page' do
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    # Then I see a link to update the merchant's information. When I click the link
    # Then I am taken to a page to edit this merchant
    visit edit_admin_merchant_path(@merchant_1.id)
    # And I see a form filled in with the existing merchant attribute information
    expect(page).to have_field("Merchant's Name")
    
    # When I update the information in the form and I click ‘submit’
    fill_in(:name, with: "Amazonn")
    click_button("Submit")
    
    # Then I am redirected back to the merchant's admin show page where I see the updated information
    expect(current_path).to eq(admin_merchant_path(@merchant_1.id))

    expect(page).to have_content("Amazonn")

    # And I see a flash message stating that the information has been successfully updated.
    within "#flash" do
      expect(page).to have_content("The information has been successfully updated for Amazonn")
    end
  end

  #Sad path testing for user story #26
  it "responds to incomplete information in the form" do
    visit edit_admin_merchant_path(@merchant_1.id)
    fill_in(:name, with: "")
    click_button("Submit")

    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1.id))

    within "#flash" do
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
 end
end