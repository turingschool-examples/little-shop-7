require "rails_helper"

RSpec.describe "Admin Merchants Dashboard" do
  before :each do
    load_test_data
  end

  # US 24
  describe "As an admin, When I visit the admin merchants index (/admin/merchants)" do
    it "I see the name of each merchant in the system" do

      visit admin_merchants_path

      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_content(@merchant1.name)
      end

      within("#merchant-#{@merchant2.id}") do
        expect(page).to have_content(@merchant2.name)
      end

      within("#merchant-#{@merchant3.id}") do
        expect(page).to have_content(@merchant3.name)
      end
    end
  end
end