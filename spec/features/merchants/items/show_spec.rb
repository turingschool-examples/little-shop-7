require "rails_helper" 

RSpec.describe "Merchant's Item's Show Page" do 
  before(:each) do 
    load_test_data
  end
  it "shows a list of all of the item's attributes" do 
    visit "merchants/#{@merchant1.id}/items"

    within ""
  end
end