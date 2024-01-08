require "rails_helper"

RSpec.describe "the merchant dashboard index page" do
  it "shows the merchant's name (User Story 1)" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end

  it "shows links to the merchant's item and invoice indices (User Story 2)" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"


    expect(page).to have_link 'View Items', href: "/merchants/#{merchant.id}/items"
    expect(page).to have_link 'View Invoices', href: "/merchants/#{merchant.id}/invoices"
  end
end
