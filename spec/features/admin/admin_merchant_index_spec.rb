require "rails_helper"

RSpec.describe "Admin Merchant Index Page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers", status: :disabled)
    @merchant_2 = Merchant.create!(name: "Kwik-E-Mart", status: :enabled)
    @merchant_3 = Merchant.create!(name: "Strickland Propane", status: :disabled)
  end

  describe "When I visit the merchant index (/admin/merchants)" do
    # US 24
    it "I see a list of all the merchants" do
      visit admin_merchants_path
      expect(Merchant.all.count).to eq(3) # sanity check

      Merchant.all.each do |merchant|
        expect(page).to have_content(merchant.name)
      end
      
      expect(page).not_to have_link("The Android's Dungeon & Baseball Card Shop")
    end
  end

  # US 25
  describe "When I visit the merchant index (/admin/merchants)" do
    it "I can click on a merchant name and be taken to the merchant show page" do

      visit admin_merchants_path

      within ".merchants" do
        click_link("Bob's Burgers")
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end
    end
  end


  describe "When I visit the admin merchants index" do 
    it "Then next to each merchant name I see a button to disable or enable that merchant." do 

        visit '/admin/merchants'

        within "#disabled_merchants" do 
          expect(page).to have_button("Enable #{@merchant_1.name}")
          expect(page).to have_button("Enable #{@merchant_3.name}")
        end
      
        within "#enabled_merchants" do
        expect(page).to have_button("Disable #{@merchant_2.name}")
        end
      end
    

      it "When I click this button I am redirected back to the admin merchants index and I see the merchant's status has changed." do 
        visit admin_merchants_path

        within "#disabled_merchants" do 
          click_button("Enable #{@merchant_3.name}")
          expect(current_path).to eq(admin_merchants_path)
        end

        within "#enabled_merchants" do
          expect(page).to have_button("Disable #{@merchant_3.name}")
          click_button("Disable #{@merchant_2.name}")
          expect(current_path).to eq(admin_merchants_path)
        end

        within "#disabled_merchants" do 
          expect(page).to have_button("Enable #{@merchant_1.name}")
        end
      end
  end
end
