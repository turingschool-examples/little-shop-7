require "rails_helper"

RSpec.describe "admin dashboard index page" do
  it "Displays a admin dashboard header" do
    visit admin_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "Displays the names of the top 5 customers" do
    visit admin_path
    expect(page).to have_content("Ilene Phannerstill, 7")
    expect(page).to have_content("Markus Grady, 6")
    expect(page).to have_content("Rollin Morar, 6")
    expect(page).to have_content("Amelia Schuster, 6")
    expect(page).to have_content("Austen Wyman, 6")
  end
end
