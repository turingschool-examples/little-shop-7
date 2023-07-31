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
        
        expect(current_path).to eq(edit_admins_merchant_path(@merchants[0].id))
        expect(page).to have_css("#merchant_edit_form")
        within "#merchant_edit_form" do
          expect(page).to have_field("merchant[name]", with: @merchants[0].name)
        end
      end
      it "When I update the information in the form and I click 'submit' Then I am redirected back to the merchant's admin show page where I see the updated information And I see a flash message stating that the information has been successfully updated." do
        visit edit_admins_merchant_path(@merchants[0].id)
        within "#merchant_edit_form" do
          fill_in("merchant[name]", with: "Updated Merchant Name Garfield")
          click_button type: "submit"
        end
        
        expect(current_path).to eq("/admins/merchants/#{@merchants[0].id}")
        expect(page).to have_content("Updated Merchant Name Garfield")
        expect(page).to have_content("Merchant information was successfully updated.")
      end
    end
  end
end