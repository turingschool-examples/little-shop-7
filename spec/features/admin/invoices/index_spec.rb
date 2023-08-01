require "rails_helper"

RSpec.describe "Invoices index page", type: :feature do
  describe "As an admin, When I visit the admin Invoices index (/admin/invoices)" do
    it "Then I see a list of all Invoice ids in the system Each id links to the admin invoice show page" do
      test_data
      invoices = Invoice.all
      visit "/admin/invoices"

      invoices.each do |invoice|
        expect(page).to have_content("#{invoice.id}")
      end
      save_and_open_page
    end
  end
end