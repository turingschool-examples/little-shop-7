require "rails_helper"

RSpec.feature "Admin Dashboard" do 
  it "has a header" do 
    visit '/admin'

    expect(find(".header")).to have_content("Admin Dashboard")
  end

  it "has link to the admin merchants index" do 
    visit '/admin'

    expect(page).to have_link("Admin: All Merchants")
    expect(page).to have_link("Admin: All Invoices")
  end
end