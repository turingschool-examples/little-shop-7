require "rails_helper"

RSpec.describe "Merchant Dashboard Page", type: :feature do
  
  before(:each) do
    @merchant1 = Merchant.create!(name:"Merchy McMerchface")
  end

  it "shows the merchant name" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    within("div#merchant-header") do
      expect(page).to have_content(@merchant1.name).once
    end
  end

end