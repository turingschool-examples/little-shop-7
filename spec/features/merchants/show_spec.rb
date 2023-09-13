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
end


# As a merchant,
# When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
# Then I see link to my merchant items index (/merchants/:merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)