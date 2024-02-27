require 'rails_helper'

RSpec.describe 'Admin Merchants Show', type: :feature do
 describe 'As an Admin' do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Amazon") 
  end

  #User Story 25. Admin Merchant Show
  it 'displays merchants name' do
    # As an admin, When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
    visit admin_merchants_path
    within "#disabled_merchants" do
      within "#merchant_#{@merchant_1.id}" do
        click_link("Amazon")
        # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      end
    end
    expect(current_path).to eq(admin_merchant_path(@merchant_1.id))
    # And I see the name of that merchant    
    expect(page).to have_content("Amazon")
  end

  #User Story 26.
  it 'displays a link to update merchants information, and updates it successfully' do
    # As an admin,
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    visit admin_merchant_path(@merchant_1.id)
    # Then I see a link to update the merchant's information. When I click the link

    click_link("Update #{@merchant_1.name}'s Information")
    # Then I am taken to a page to edit this merchant
    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1.id))

    #Test continues in spec/features/admin/merchants/edit_spec.rb
  end
 end
end