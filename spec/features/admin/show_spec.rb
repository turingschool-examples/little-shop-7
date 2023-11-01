require "rails_helper"

RSpec.describe "admin dashboard index page" do
  it "Displays a admin dashboard header" do
    visit admin_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end
end
