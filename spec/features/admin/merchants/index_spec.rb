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
      
      it "I see a link to create a new merchant. When I click on the link, I am taken to a form that allows me to add merchant information." do
        merchants = create_list(:merchant, 4)
        merchants << create_list(:merchant, 4, status: :false)
        visit admin_merchants_path
        expect(page).to have_link("New Merchant", href: "#{new_admin_merchant_path}")
        
        click_link("New Merchant")
        expect(current_path).to eq("#{new_admin_merchant_path}")
        expect(page).to have_css("#new_merchant_form")
      end
      
      it "When I fill out the form I click 'Submit' Then I am taken back to the admin merchants index page. And I see the merchant I just created displayed And I see my merchant was created with a default status of disabled." do
        visit new_admin_merchant_path
        fill_in(:name, with: "My Merchant Name")
        click_button "Submit"
        expect(current_path).to eq("#{admin_merchants_path}")
        within "#disabled_merchants" do
          expect(page).to have_content("My Merchant Name")
        end
        expect(Merchant.all.last.status).to eq(false)
      end

      it "Then I see the names of the top 5 merchants by total revenue generated with total revenue next to each" do
        
        merchants = create_list(:merchant, 10)
      
        successful_merchants = merchants[0..4]
        successful_merchants.each do |merchant|
          customer = create(:customer)
          item = create(:item, merchant: merchant)
          invoice = create(:invoice, customer: customer, status: "completed")
          create(:invoice_item, invoice: invoice, item: item, unit_price: 1000, quantity: rand(5..10), status: :shipped)
        end
        
        visit admin_merchants_path
      
        expect(page).to have_content("Top Merchants")

        within("#top_merchants") do
          successful_merchants.each do |merchant|
            expect(page).to have_link(merchant.name, href: admin_merchant_path(merchant))
            expect(page).to have_content('$')
          end
          (merchants - successful_merchants).each do |merchant|
            expect(page).not_to have_link(merchant.name, href: admin_merchant_path(merchant))
          end
        end
      end
    end
  end
end