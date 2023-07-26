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

        
      end

      it "And next to each customer name I see the number of successful transactions they have
      conducted" do
      test_data
      visit admins_path
      end

    end
  end

end

