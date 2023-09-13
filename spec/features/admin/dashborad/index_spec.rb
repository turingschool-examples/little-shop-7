require "rails_helper"

RSpec.describe "the admin index" do
  it "displays a header at the top of the dashboard" do
    
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  
  end
end