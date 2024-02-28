require 'rails_helper'

RSpec.describe 'Welcome Index', type: :feature do
  describe 'As anyone' do
    it "displays links to merchants index and admin index, and after clicking both takes us to the correct path" do
      visit "/"
      expect(page).to have_link("Admin")
      expect(page).to have_link("Merchant")

      click_link("Admin")
      expect(current_path).to eq(admin_index_path)

      click_link("Merchant")
      expect(current_path).to eq(merchants_path)
    end
  end
end