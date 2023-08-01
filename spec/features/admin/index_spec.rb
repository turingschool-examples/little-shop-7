require "rails_helper"

RSpec.describe "Admin", type: :feature do
  
  describe "as an admin" do
    describe "When I visit the admin dashboard (/admin)" do
      it "Then I see a header indicating that I am on the admin dashboard" do
        visit admin_index_path 
        within "#header" do 
          expect(page).to have_content("Admin Dashboard")
        end
      end
      
      it "Then I see a link to the admin merchants index (/admin/merchants)" do
        visit admin_index_path 
        within "#header" do 
          expect(page).to have_link("Merchants", href: "/admin/merchants")
        end
      end
      
      it "And I see a link to the admin invoices index (/admin/invoices)" do
        visit admin_index_path 
        within "#header" do 
          expect(page).to have_link("Invoices", href: "/admin/invoices")
        end
      end
      
      it "Then I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
        test_data
        visit admin_index_path

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
        visit admin_index_path
        
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
        visit admin_index_path

        expect(page).to have_css("#incomplete_invoices")

      end

      it "In that section I see a list of all the invoice ids that have unshipped items" do
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        merchant = create(:merchant)
        invoices = Array.new
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_1))
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_2))
        
        invoices[0..1].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 0)
        end
        invoices[2..3].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 1)
        end
        invoices[4..5].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 2)
        end
        visit admin_index_path
        within "#incomplete_invoices" do
          expect(page).to_not have_content("Invoice ##{invoices[0].id}")
          expect(page).to_not have_content("Invoice ##{invoices[1].id}")
          expect(page).to have_content("Invoice ##{invoices[2].id}")
          expect(page).to have_content("Invoice ##{invoices[3].id}")
          expect(page).to have_content("Invoice ##{invoices[4].id}")
          expect(page).to have_content("Invoice ##{invoices[5].id}")
          # "And each invoice id links to that invoice's admin show page"
          expect(page).to have_link("#{invoices[2].id}", href: "/admin/invoices/#{invoices[2].id}")
          expect(page).to have_link("#{invoices[4].id}", href: "/admin/invoices/#{invoices[4].id}")
        end
      end

      it "Next to each invoice id I see the date that the invoice was created And I see the date formatted like 'Monday, July 18, 2019' And I see that the list is ordered from oldest to newest" do
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        merchant = create(:merchant)
        invoices = Array.new
        invoices.concat(create_list(:invoice, 3, status: "in progress", customer: customer_1, created_at: Time.new(2023, 6, 5)))
        invoices.concat(create_list(:invoice, 2, status: "in progress", customer: customer_2, created_at: Time.new(2023, 6 ,13)))
        invoices.concat(create_list(:invoice, 1, status: "in progress", customer: customer_1, created_at: Time.new(2023, 7 ,5)))
        invoices.concat(create_list(:invoice, 2, status: "in progress", customer: customer_2, created_at: Time.new(2023, 7 ,20)))
        invoices.concat(create_list(:invoice, 1, status: "in progress", customer: customer_1, created_at: Time.new(2023, 7 ,23)))
        
        invoices[0..2].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 0)
        end
        invoices[3..5].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 1)
        end
        invoices[6..8].each do |invoice|
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, invoice: invoice, item: item, status: 2)
        end
        visit admin_index_path

        within "#incomplete_invoices" do
          expect(page).to_not have_content(invoices[0].id)
        end
      end
    end
  end
end
