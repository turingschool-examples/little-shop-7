require "rails_helper"

RSpec.describe "the merchant show" do
  it "shows the merchants name" do
    merchant = Merchant.create(name: "Bob Burger")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end

  it "displays a link to the merchant items idex page and a link to the merchant invoices index" do 
    merchant = Merchant.create(name: "Bob Burger")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link('items_index')
    expect(page).to have_link('invoices_index')

  end

  describe "advanced features" do
    before(:each) do
      load_test_data
    end

  it "gives top 5 customers and items bought" do

    visit "/merchants/#{@merchant1.id}/dashboard"

    # save_and_open_page
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to have_content(@customer_2.first_name)
    expect(page).to have_content(@customer_2.last_name)
    expect(page).to have_content(20)
    expect(page).to have_content(12)
    
   end
  it "gives not shipped items and ids" do

    visit "/merchants/#{@merchant1.id}/dashboard"

    # save_and_open_page
    # expect(page).to have_content(@customer_1.first_name)
    # expect(page).to have_content(@customer_1.last_name)
    # expect(page).to have_content(@customer_2.first_name)
    # expect(page).to have_content(@customer_2.last_name)
    # expect(page).to have_content(20)
    # expect(page).to have_content(12)
    
   end
  end
end


# As a merchant,
# When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
# Then I see link to my merchant items index (/merchants/:merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)