require "rails_helper"

RSpec.describe "Merchant Dashboard Page", type: :feature do
  
  before(:each) do
    @merchant1 = Merchant.create!(name:"Merchy McMerchface")
  end

  # 1. Merchant Dashboard
  it "shows the merchant name" do
    visit dashboard_merchant_path(@merchant1)

    within("div#merchant-header") do
      expect(page).to have_content(@merchant1.name).once
    end
  end

  # 2. Merchant Dashboard Links
  it "has links to the merchant items index and the invoice items index" do 
    visit dashboard_merchant_path(@merchant1)

    within("div#merchant-header") do
      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
    end
  end
end