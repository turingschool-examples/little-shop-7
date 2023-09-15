require "rails_helper"

RSpec.describe "Admin Merchants" do 
  before :each do 
    load_test_data
  end 

  # US 25- Merchant Show
  it "takes you to the merchants show page" do 
    visit '/admin/merchants'
    
    click_link("Catbus")
    expect(page).to have_current_path("/admin/merchants/#{@merchant7.id}")
    expect(page).to have_content("Catbus Page")
    expect(page).to_not have_content("Kiki")
  end
end 
