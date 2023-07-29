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

      within "#disabled_merchants" do
        click_link("Bob's Burgers")
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end
    end
  end

  describe "When I visit the admin merchants index" do 
    # US 27 & 28
    it "Then next to each merchant name I see a button to disable or enable that merchant." do 

      visit admin_merchants_path

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
        expect(page).to_not have_button("Enable #{@merchant_3.name}")
        expect(page).to have_button("Enable #{@merchant_2.name}")
      end


      within "#enabled_merchants" do
        expect(page).to have_button("Disable #{@merchant_3.name}")
        expect(page).not_to have_button("Disable #{@merchant_2.name}")
        expect(page).not_to have_button("Disable #{@merchant_1.name}")
      end
    end

    # US 29
    describe "I see a link to create a new merchant." do
      it "When I click on the link, I am taken to a form that allows me to add merchant information." do 
        visit admin_merchants_path

        expect(page).to have_link("Create New Merchant")

        click_link("Create New Merchant")
        
        expect(current_path).to eq(new_admin_merchant_path)

        fill_in "Name", with: "Yak's R Us"
        click_button("Create Merchant")

        expect(current_path).to eq(admin_merchants_path)
        
        within "#disabled_merchants" do
          expect(page).to have_content("Yak's R Us")
          expect(page).to have_button("Enable Yak's R Us")
        end
      end
    end

    describe "Top 5 Merchants by Revenue" do
      describe "Then I see the names of the top 5 merchants by total revenue generated." do
        it "And next to each of the names I see the total revenue generated for that merchant." do
          visit admin_merchants_path

          within "#top_merchants" do 
            expect(page).to have_content("Top 5 Merchants by Revenue")

          end
        end
      end
    end
  end
end
