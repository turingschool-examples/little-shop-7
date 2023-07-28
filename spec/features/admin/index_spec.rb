require "rails_helper"



RSpec.describe "Admin", type: :feature do

  describe "as an admin" do
    describe "When I visit the admin dashboard (/admin)" do
      it "Then I see a header indicating that I am on the admin dashboard" do
        
        visit admins_path 
        within "#header" do 
         expect(page).to have_content("Admin Dashboard")
        end
      end

      it "Then I see a link to the admin merchants index (/admin/merchants)" do
        visit admins_path 
        within "#header" do 
         expect(page).to have_link("Merchants", href: "/admin/merchants")
        end
      end

      it "And I see a link to the admin invoices index (/admin/invoices)" do
        visit admins_path 
        within "#header" do 
         expect(page).to have_link("Invoices", href: "/admin/invoices")
        end
      end

      it "Then I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
        test_data
        visit admins_path

        within "#top_5_customers" do
          expect("#{@customer_1.last_name}").to appear_before("#{@customer_2.last_name}")
          expect("#{@customer_2.last_name}").to appear_before("#{@customer_3.last_name}")
          expect("#{@customer_3.last_name}").to appear_before("#{@customer_4.last_name}")
          expect("#{@customer_4.last_name}").to appear_before("#{@customer_5.last_name}")
        end
      end

      it "And next to each customer name I see the number of successful transactions they have
      conducted" do
      test_data
      visit admins_path

      within "#top_5_customers" do
        expect("5").to appear_after("#{@customer_1.last_name}")
        expect("4").to appear_after("#{@customer_2.last_name}")
        expect("3").to appear_after("#{@customer_3.last_name}")
        expect("2").to appear_after("#{@customer_4.last_name}")
        expect("1").to appear_after("#{@customer_5.last_name}")
      end
    end
  end
end
