require 'rails_helper'

RSpec.describe "Admin Merchants Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  # US 24
  it "displays the name of each merchant" do
    visit admin_merchants_path

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end
end