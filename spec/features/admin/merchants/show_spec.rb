require "rails_helper"

RSpec.describe "the merchants show page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Sooyung LLC")
    @merchant2 = Merchant.create!(name: "Joseph LLC")
    @merchant3 = Merchant.create!(name: "Anthea LLC")
    @merchant4 = Merchant.create!(name: "Nathan LLC")
  end

  it "takes me to the merchant's admin show page when i click the link, which has the merchant name listed there" do
    visit "/admin/merchants"
    click_on("#{@merchant1.name}")
    expect(page).to have_current_path("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content(@merchant1.name)
  end
end
