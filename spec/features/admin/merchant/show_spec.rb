require "rails_helper"

RSpec.describe "Admin Merchant Show Page" do 
  it "a user can click on any Merchant in Admin Merchant Index to get taken to that Merchan'ts Show Page" do 
    # as an admin
    merchant = Merchant.create!({name: "Schroeder-Jerde"})

    visit "/admin/merchants"

    click_link merchant.name

    expect(current_path).to eq("/admin/merchants/#{merchant.id}")
    expect(page).to have_content("#{merchant.name}")
  end

  it "can update the merchant's information" do 
    # as an admin
    visit "/admin/merchants/#{merchant.id}"

    expect(page).to have_link("Update")

    click("Update")

    visit "/admin/merchants/#{merchant.id}/edit"

    expect(page).to have_content

  end

end 