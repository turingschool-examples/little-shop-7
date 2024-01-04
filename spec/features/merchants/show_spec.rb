require "rails_helper"

RSpec.describe "show page" do
  before (:each) do

  @merchant_1 = Merchant.create!(name: "Walmart")

  end

  it "displays the merchant name on the dashboard page" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content(@merchant_1.name)
  end
end

