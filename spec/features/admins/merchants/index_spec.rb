require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  
  describe "As an admin" do
    describe "When I visit the admin merchants index (/admin/merchants)" do
      it "Then I see the name of each merchant in the system" do
        merchants = create_list(:merchant, 8)
        visit admin_merchants_path

        within "#merchant_list" do
          merchants.each do |merchant|
            expect(page).to have_content(merchant.name)
          end
        end
      end

      it "Then next to each merchant name I see a button to disable or enable that merchant" do
        merchants = create_list(:merchant, 8)
        visit admin_merchants_path

        within "#merchant_list" do
          merchants.each do |merchant|
            expect(page).to have_css("##{merchant.id}_button")
          end
        end
      end
      
      it "When I click this button, Then I am redirected back to the admin merchants index and see status changed" do
        merchants = create_list(:merchant, 4)
        merchants << create_list(:merchant, 4, :false)
        visit admin_merchants_path

        expect(page).to have_button("Disable", id: "#{merchants.first.id}_button")
        find("##{merchants.first.id}_button").click
        
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_no_button("Disable", id: "#{merchants.first.id}_button")
        expect(page).to have_button("Enable", id: "#{merchants.first.id}_button")
        
      end

      describe "story 28" do
        it "I see two sections, one for Enabled Merchants and one for Disabled Merchants" do
          merchants = create_list(:merchant, 3)
          merchants.concat(create_list(:merchant, 3, status: :false))
          visit admin_merchants_path
          within "#enabled_merchants" do
            expect(page).to have_content(merchants[0].name)
            expect(page).to have_content(merchants[1].name)
            expect(page).to have_content(merchants[2].name)
          end

          within "#disabled_merchants" do
            expect(page).to have_content(merchants[3].name)
            expect(page).to have_content(merchants[4].name)
            expect(page).to have_content(merchants[5].name)
          end
        end

      end
    end
  end
end