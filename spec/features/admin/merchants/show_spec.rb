require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  
  describe "As an admin" do
    describe "When I click on the name of a merchant from the admin merchants index page (/admin/merchants)" do
      it "Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id) And I see the name of that merchant" do
        merchant = create(:merchant)
        visit admins_merchant_path(merchant.id)
        save_and_open_page
        within "#merchant_info" do
          expect(page).to have_content(merchant.name)
        end
      end
    end
  end
end