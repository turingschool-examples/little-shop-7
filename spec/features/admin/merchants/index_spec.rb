require "rails_helper"

RSpec.describe "Admin/merchants index page", type: :feature do
  
  describe "As an admin" do
    describe "When I visit the admin merchants index (/admin/merchants)" do
      it "Then I see the name of each merchant in the system" do
        merchants = create_list(:merchant, 8)
        visit admins_merchants_path

        within "#merchant_list" do
          merchants.each do |merchant|
            expect(page).to have_content(merchant.name)
          end
        end
      end

      it "Then next to each merchant name I see a button to disable or enable that merchant" do
        merchants = create_list(:merchant, 8)
        visit admins_merchants_path

        within "#merchant_list" do
          merchants.each do |merchant|
            expect(page).to have_css("##{merchant.id}_button")
          end
        end
      end
      
      it "When I click this button, Then I am redirected back to the admin merchants index and see status changed" do
        merchants = create_list(:merchant, 4)
        merchants << create_list(:merchant, 4, status: :false)
        visit admins_merchants_path
        save_and_open_page

        expect(page).to have_button("Disable", id: "#{merchants.first.id}_button")
        find("##{merchants.first.id}_button").click
        expect(current_path).to eq(admins_merchants_path)
        expect(page).to have_no_button("Disable", id: "#{merchants.first.id}_button")
        expect(page).to have_button("Enable", id: "#{merchants.first.id}_button")
        save_and_open_page
      end
      
      xit "TEST WITHOUT FACTORYBOT" do
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: true)
        merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", status: true)
        merchant_3 = Merchant.create!(name: "Willms and Sons", status: false)
        visit admins_merchants_path
        save_and_open_page

        expect(page).to have_button("Disable", id: "#{merchant_1.id}_button")
        find("##{merchant_1.id.id}_button").click
        expect(current_path).to eq(admins_merchants_path)
        expect(page).to have_no_button("Disable", id: "#{merchants.first.id}_button")
        expect(page).to have_button("Enable", id: "#{merchants.first.id}_button")
        save_and_open_page
      end

    end
  end
end