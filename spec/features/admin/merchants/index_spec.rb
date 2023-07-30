require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  
  describe "As an admin" do
    describe "When I visit the admin merchants index (/admin/merchants)" do
      it "Then I see the name of each merchant in the system" do
        visit "/admin/merchants"

        merchants = create_list(:merchant, 8)
        within "#merchant_list" do
          merchants.each do |merchant|
            expect(page).to have_content(merchant.name)
          end
        end
      end
    end
  end
end