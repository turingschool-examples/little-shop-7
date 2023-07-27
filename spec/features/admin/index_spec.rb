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
          expect("#{@customer_5.last_name}").to appear_before("#{@customer_4.last_name}")
        end
      end

      it "And next to each customer name I see the number of successful transactions they have
      conducted" do
        test_data
        visit admins_path
        save_and_open_page
        within "#top_5_customers" do
          expect("#{@customer_1.last_name}").to appear_before(" - 16")
          expect("#{@customer_2.last_name}").to appear_before(" - 6")
          expect("#{@customer_3.last_name}").to appear_before("4 purchases")
          expect("#{@customer_4.last_name}").to appear_before(" - 4")
          expect("#{@customer_5.last_name}").to appear_before("4 purchases")
        end
      end
    end
  end
end

customers.joins(:transactions)
                        .where("transactions.result = 'success'") 
                        .group('customers.id')
                        .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, customers.*, COUNT(customers.id) AS customer_count")
                        .order('customer_count DESC')
                        .limit(5)