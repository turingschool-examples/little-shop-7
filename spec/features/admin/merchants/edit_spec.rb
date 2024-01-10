# As an admin,
# When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
require 'rails_helper'
RSpec.describe "Admin Merchant Update" do 
  it " can update the admin merchant" do 
    # As an admin,
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    @merchant_1 = create(:merchant)
    visit admin_merchant_path(@merchant_1)
    # Then I see a link to update the merchant's information.
    expect(page).to have_link("Update Merchant Information")
    # When I click the link
    click_on("Update Merchant Information")
    # Then I am taken to a page to edit this merchant
    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1.id))
    # And I see a form filled in with the existing merchant name
    expect(page).to have_field(:"Merchant Name", :with => @merchant_1.name)
    # When I update the information in the form
    fill_in "Merchant Name", with: "Updated Merchant Name"
    # and I click ‘submit’
    click_on('Submit')

    # Then I am redirected back to the merchant's admin show page 
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    # where I see the updated information
    expect(page).to have_content("Updated Merchant Name")
    expect(page).to_not have_content(@merchant_1.name)
    # And I see a flash message stating that the information has been successfully updated.
    expect(page).to have_content("Information has succesfully been updated")
  end

  it "throws an error if update doesn't work :)" do
    #As an admin
    # when I visit admin merchants edit page
    merchant_1 = create(:merchant)

    visit edit_admin_merchant_path(merchant_1.id)
    # And I input invalid data (blank field)
    fill_in("Merchant Name", with: "")
    # and click submit
    click_button("Submit")
    # I am taken back to the admin merchants edit page
    expect(current_path).to eq(edit_admin_merchant_path(merchant_1))
    # And I see a flash message that tells me name can't be blank
    expect(page).to have_content("Name can't be blank")
    # And the merchant data was not changed
    expect(page).to have_content(merchant_1.name)
  end
end
