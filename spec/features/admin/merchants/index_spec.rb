require "rails_helper"

RSpec.describe "Admin Merchant" do

  let!(:merchant1) {Merchant.create!(name: 'Stuff Emporium', status: 0)}
  let!(:merchant2) {Merchant.create!(name: 'Junk', status: 1)}
  let!(:merchant3) {Merchant.create!(name: 'Homemade stuff', status: 0)}
  let!(:merchant4) {Merchant.create!(name: 'Cool Stuff', status: 1)}
  
  it "displays merchant index page" do
    visit "/admin/merchants"
    expect(page).to have_content("Name: Stuff Emporium")
    expect(page).to have_content("Junk")
    expect(page).to have_content("Homemade stuff")
    expect(page).to have_content("Cool Stuff")
  end
  it "changes merchant status" do
    visit "/admin/merchants"
    click_button "Disable #{merchant1.name}"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(merchant1.status).to eq("Disabled")
  end
  # As an admin,
  # When I visit the admin merchants index (/admin/merchants)
  # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
  # And I see that each Merchant is listed in the appropriate section
  
  it "sorts disabled merchants" do
    visit "/admin/merchants"
    within("#Disabled_merchants") do
      expect(page).to have_content("Stuff Emporium")
      expect(page).to have_content("Homemade stuff")
      expect(page).to_not have_content("Cool Stuff")
    end
  end

  it "sorts enabled merchants" do
    visit "/admin/merchants"
    within("#Enabled_merchants") do
      expect(page).to have_content("Junk")
      expect(page).to have_content("Cool Stuff")
      expect(page).to_not have_content("Homemade stuff")
    end
  end
    


end
