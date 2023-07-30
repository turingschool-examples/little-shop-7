require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  
  describe "As an admin" do
    describe "When I click on the name of a merchant from the admin merchants index page (/admin/merchants)" do
      it "Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id) And I see the name of that merchant" do
        merchants = create_list(:merchant, 8)
        visit admins_merchants_path
        
        within "#merchant_list" do
          click_link("#{merchants[0].name}")
        end
        
        save_and_open_page
        expect(current_path).to eq("/admins/merchants/#{merchants[0].id}")
        expect(page).to have_content("#{merchants[0].name}")
      end
    end
  end
end