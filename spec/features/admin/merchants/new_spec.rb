require 'rails_helper'

RSpec.describe "merchant new page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Sooyung LLC")
    @merchant2 = Merchant.create!(name: "Joseph LLC")
    @merchant3 = Merchant.create!(name: "Anthea LLC")
    @merchant4 = Merchant.create!(name: "Nathan LLC")
  end

  it "has a link to create a new merchant" do
    visit "admin/merchants"
    expect(page).to have_link("Create a new merchant")
    expect(Merchant.count).to eq(4)
  end

  it "takes me to the create page when I click the link" do
    visit "admin/merchants"
    expect(page).to have_link("Create a new merchant")
    click_link("Create a new merchant")
    expect(page).to have_current_path("/admin/merchants/new")
  end

  it "redirects me to the merchants index page when I click submit, where I see the newly created company" do
    visit "admin/merchants/new"

    expect(page).to have_content("Create a new company")
    expect(page).to have_field(:new_company_name)
    expect(page).to have_button("Submit")

    fill_in :new_company_name, with: "Best Company Ever"
    click_on("Submit")
    expect(page).to have_current_path("/admin/merchants")
    expect(page).to have_content("Best Company Ever")
    expect(Merchant.count).to eq(5)
  end
end