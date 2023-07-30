require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  before(:each) do
    @merchants = create_list(:merchant, 8)
  end
  
  describe "As an admin" do
    describe "When I click on the name of a merchant from the admin merchants index page (/admin/merchants)" do
      it "Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id) And I see the name of that merchant" do
        
        visit admins_merchants_path
        
        within "#merchant_list" do
          click_link("#{@merchants[0].name}")
        end
        
        expect(current_path).to eq("/admins/merchants/#{@merchants[0].id}")
        expect(page).to have_content("#{@merchants[0].name}")
      end
    end
    
    describe "When I visit a merchant's admin show page (/admin/merchants/:merchant_id)" do
      it "Then I see a link to update the merchant's information." do
        visit admins_merchant_path(@merchants[0].id)

        expect(page).to have_link("Update Merchant")
      end

      it "When I click the link Then I am taken to a page to edit this merchant And I see a form filled in with the existing merchant attribute information" do
        visit admins_merchant_path(@merchants[0].id)
        click_link("Update Merchant")
        save_and_open_page

        expect(current_path).to eq("/admins/merchants/#{@merchants[0].id}/edit")
        expect(page).to have_css("edit_merchant_form")
        within "edit_merchant_form" do
          expect(page).to have_content(@merchants[0].name)
        end
      end
    end
  end
end