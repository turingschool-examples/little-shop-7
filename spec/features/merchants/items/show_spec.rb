require "rails_helper" 

RSpec.describe "Merchant's Item's Show Page" do 
  before(:each) do 
    load_test_data
  end
  it "shows a list of all of the item's attributes" do 
    visit "/merchants/#{@merchant1.id}/items/#{@item5.id}"
    save_and_open_page
    within "#product_header" do 
      expect(page).to have_content(@item5.name)
    end

    within "#item_details" do 
      expect(page).to have_content("Item description #{@item5.description}")
      expect(page).to have_content("Current Selling price: $4.00")
    end
  end
end