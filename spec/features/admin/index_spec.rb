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
          within "#top_five_#{@customer_1.first_name}#{@customer_1.last_name}" do
            expect(page).to have_content("4 transactions")
          end
          within "#top_five_#{@customer_2.first_name}#{@customer_2.last_name}" do
            expect(page).to have_content("2 transactions")
          end
          within "#top_five_#{@customer_3.first_name}#{@customer_3.last_name}" do
            expect(page).to have_content("2 transactions")
          end
          within "#top_five_#{@customer_4.first_name}#{@customer_4.last_name}" do
            expect(page).to have_content("2 transactions")
          end
          within "#top_five_#{@customer_5.first_name}#{@customer_5.last_name}" do
            expect(page).to have_content("2 transactions")
          end
        end
      end

      it "Then I see a section for Incomplete Invoices" do
        visit admins_path

        expect(page).to have_css("#incomplete_invoices")

      end

      it "In that section I see a list of all the invoice ids that have unshipped items" do
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        merchant = create(:merchant)
        invoices = Array.new
        invoices.concat(create_list(:invoice, 3, status: "completed", customer: customer_1))
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_2))
        
        invoices.each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item)
        end
        
        visit admins_path
        
        within "#incomplete_invoices" do
          expect(page).to_not have_content(invoices[0].id)
          expect(page).to have_content(invoices[3].id)
          expect(page).to have_content(invoices[4].id)
          expect(page).to have_content(invoices[5].id)
          # "And each invoice id links to that invoice's admin show page"
          expect(page).to have_link("#{invoices[3].id}", href: "/admin/invoices/#{invoices[3].id}")
        end
      end
    end
  end
end