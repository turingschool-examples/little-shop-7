require 'rails_helper'

RSpec.describe 'Welcome Index', type: :feature do
  describe 'As anyone' do
    it "displays links to merchants index and admin index" do
      visit "/"
      save_and_open_page
      expect(page).to have_link("Admin")
      expect(page).to have_link("Merchant")
    end
  end
end