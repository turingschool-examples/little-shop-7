require "rails_helper"

RSpec.describe "Merchant Invoice Show page" do 
  before(:each) do 
    load_test_data
  end
  it "shows a list of all my items" do 
    visit "merchants/#{@merchant1.id}/invoices/#{@invoice_1.id}"

    within "#single_invoice" do 
       expect(page).to have_content(@invoice_1.id)
       expect(page).to have_content(@invoice_1.status.capitalize)
       expect(page).to have_content("Friday, September 15, 2023")
       expect(page).to have_content(@invoice_1.customer.first_name)
       expect(page).to have_content(@invoice_1.customer.last_name)
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