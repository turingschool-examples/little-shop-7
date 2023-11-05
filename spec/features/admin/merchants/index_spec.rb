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

  #   As an admin,
# When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
# Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
# And I see the name of that merchant
  # US 25
  it "clicking the name redirects to merchant admin show page and displays the name" do
    visit admin_merchants_path

    expect(page).to have_link("#{@merchant1.name} ##{@merchant1.id}")
    click_link("#{@merchant1.name} ##{@merchant1.id}")

    expect(current_path).to eq(admin_merchant_path(@merchant1.id))

    expect(page).to have_content(@merchant1.name)
  end
end