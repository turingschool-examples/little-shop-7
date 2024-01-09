
require 'rails_helper'
 
RSpec.describe 'Admin Merchants Create', type: :feature do
  
  before(:each) do

    visit admin_merchants_path

    click_on "Create Merchant"
  end

  it "create a new merch" do 
    expect(current_path).to eq(new_admin_merchant_path)

    fill_in :name, with: "Popeyes"
    
    click_on "Submit"
    
    # save_and_open_page
    expect(current_path).to eq(admin_merchants_path)

    within "#disabled_merch" do 
      expect(page).to have_content("Popeyes")
    end
  end

  it "sad path for create" do

    expect(current_path).to eq(new_admin_merchant_path)

    fill_in :name, with: ""
    
    click_on "Submit"
    # save_and_open_page
    expect(current_path).to eq(new_admin_merchant_path)

    expect(page).to have_content("Error: All fields must be filled in to submit")
  end 
end