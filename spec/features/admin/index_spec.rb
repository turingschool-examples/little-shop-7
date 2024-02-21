require 'rails_helper'

RSpec.describe 'Admin Dashboard (Index)', type: :feature do
  describe 'As an admin' do
    before(:each) do
      @customers = create_list(:customer, 10)
    end

    #User Story 19
    it 'displays the admin dashboard header' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path
      
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")
    end

    #User Story 20. Admin Dashboard Links
    it 'displays links to admin merchants and invoices index' do
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path

      # Then I see a link to the admin merchants index (/admin/merchants)
      expect(page).to have_link(href: "/admin/merchants")

      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link(href: "/admin/invoices")
    end

    #User Story 21. Admin Dashboard Statistics - Top Customers
    it 'displays the names of the top 5 customers and the number of successful transactions they have conducted' do
      @customers.each do |customer| 
        customer.invoices.last.transactions.last.delete if @customers.index(customer) > 4
      end
      
      # As an admin,
      # When I visit the admin dashboard (/admin)
      visit admin_index_path

      within "#top_customers" do
        # Then I see the names of the top 5 customers
        within "#top_customer#{@customers[0].id}" do
          # who have conducted the largest number of successful transactions
          expect(page).to have_content("#{@customers[0].first_name} #{@customers[0].last_name}")
          # And next to each customer name I see the number of successful transactions they have conducted
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customers[1].id}" do
          expect(page).to have_content("#{@customers[1].first_name} #{@customers[1].last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customers[2].id}" do
          expect(page).to have_content("#{@customers[2].first_name} #{@customers[2].last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customers[3].id}" do
          expect(page).to have_content("#{@customers[3].first_name} #{@customers[3].last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customers[4].id}" do
          expect(page).to have_content("#{@customers[4].first_name} #{@customers[4].last_name}")
          expect(page).to have_content("15 purchases")
        end
      end
    end
  end
end