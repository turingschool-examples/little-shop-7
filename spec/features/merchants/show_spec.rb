require "rails_helper"

RSpec.describe "merchant dashboard index page" do
  before :each do
    @merchant_1 = create(:merchant)
  end

  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end
end