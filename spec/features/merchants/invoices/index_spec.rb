require "rails_helper"

RSpec.describe "Merchant Invoice Index page" do 
  before(:each) do 
    load_test_data
  end
  it "shows a list of all my items" do 
    visit "merchants/#{@merchant1.id}/invoices"

    within "#merchant_name" do 
      expect(page).to have_content(@merchant1.name)
    end
    # save_and_open_page
    within "#merchant_invoices" do 
      # expect(page).to have_content("Colgate")
      # expect(page).to have_content("Red Bell Pepper")
      # expect(page).to have_content("Huskies")
      # expect(page).to have_content("Gatorade")
      # expect(page).to have_content("Pretzels")
      # expect(page).to have_content("Chicken Breast")
      # expect(page).to have_content("Coors")
      # expect(page).to have_content("Mug")
    end
  end

  # it "doesn't show the items of any other merchant" do 
  #   visit "merchants/#{@merchant1.id}/items"

  #   within "#merchant_items" do 
  #     expect(page).to_not have_content("Book")
  #     expect(page).to_not have_content("Card")
  #     expect(page).to_not have_content("Bag")
  #     expect(page).to_not have_content("Keychain")
  #     expect(page).to_not have_content("Lamp")
  #     expect(page).to_not have_content("Mouse")
  #     expect(page).to_not have_content("Clip")
  #     expect(page).to_not have_content("Shelf")
  #     expect(page).to_not have_content("Hook")
  #   end

  # end
end