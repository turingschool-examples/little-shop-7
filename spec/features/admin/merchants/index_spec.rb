require "rails_helper"

RSpec.describe "Admin Merchants Index" do 
  before :each do 
    load_test_data
  end 

  it "shows the names of each merchant in the system" do 
    
    visit '/admin/merchants'

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
    expect(page).to have_content(@merchant5.name)
    expect(page).to have_content(@merchant6.name)
    expect(page).to have_content(@merchant7.name)
    expect(page).to have_content(@merchant8.name)
    expect(page).to have_content(@merchant9.name)
    expect(page).to have_content(@merchant10.name)
  end
end