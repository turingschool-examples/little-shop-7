require "rails_helper"

RSpec.describe "merchant dashboard index page" do
  before :each do
    
  end

  it "shows the name of the merchant" do
    visit "/merchants/#{@merchant_1.id}/dashboard" # merchant_dashboard_path

    expect(page).to have_content(@merchant_1.name)
  end
end