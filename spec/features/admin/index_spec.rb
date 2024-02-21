require 'rails_helper'

RSpec.describe 'Admin Dashboard (Index)', type: :feature do
  describe 'As an admin' do
    before(:each) do
      @customers = create_list(:customer, 10)
      @customer_1 = @customers[0]
      @customer_2 = @customers[1]
      @customer_3 = @customers[2]
      @customer_4 = @customers[3]
      @customer_5 = @customers[4]
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
        within "#top_customer#{@customer_1.id}" do
          # who have conducted the largest number of successful transactions
          expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
          # And next to each customer name I see the number of successful transactions they have conducted
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customer_2.id}" do
          expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customer_3.id}" do
          expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customer_4.id}" do
          expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
          expect(page).to have_content("15 purchases")
        end

        within "#top_customer#{@customer_5.id}" do
          expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
          expect(page).to have_content("15 purchases")
        end
      end
    end
  end
end