require "rails_helper" do

RSpec.describe "it displays admin merchant show page" do
  visit "/admin/merchants"
  click_link "Merchant 1"
  expect(current_path).to eqx("/admin/merchants/#{merchant1.id}")
  expect(page).to have_content("Merchant 1")
  expect(page).to_not have_content("Merchant 2")
end