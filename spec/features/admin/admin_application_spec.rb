require "rails_helper"

RSpec.describe "admin dashboard" do
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    
    expect(page).to have_content("Welcome to the admin dashboard!")
  end
end