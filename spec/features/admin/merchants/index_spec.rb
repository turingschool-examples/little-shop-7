require "rails_helper"

RSpec.describe "Admin Merchants Index" do 
  it "shows the names of each merchant in the system" do 
    merchant_1 = Merchant.create(name: "Bob Burger")
    merchant_2 = Merchant.create(name: "Peter Griffen")
    merchant_3 = Merchant.create(name: "Dr Zoidberg")
    
    visit '/admin/merchants'
    
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
  end
end